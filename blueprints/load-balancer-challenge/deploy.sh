#!/bin/bash

# --- Configuración de Colores ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

# --- Funciones de Mensajería ---
info() { echo -e "${BOLD}==>${NC} $@"; }
success() { echo -e "${GREEN}${BOLD}✔️ SUCCESS:${NC} $@"; }
warn() { echo -e "${YELLOW}${BOLD}⚠️ WARNING:${NC} $@"; }
error() { echo -e "${RED}${BOLD}❌ ERROR:${NC} $@" >&2; exit 1; }

# --- Detección de Parámetros ---
ACTION="apply"
if [[ "$1" == "--destroy" ]]; then
    ACTION="destroy"
fi

clear
echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}${BOLD}   GCP Architect Handbook: LifeCycle Tool    ${NC}"
echo -e "${GREEN}=============================================${NC}"

# 1. Detección de Proyecto
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
REGION="us-west3"
ZONE="us-west3-b"

if [[ -z "$PROJECT_ID" ]]; then
    error "No se detectó Project ID. Ejecuta 'gcloud config set project'."
fi

# 2. Lógica de Destrucción (Confirmación en Amarillo)
if [[ "$ACTION" == "destroy" ]]; then
    echo -e "${YELLOW}${BOLD}❗ ATENCIÓN:${NC}"
    echo -e "${YELLOW}Estás a punto de eliminar todos los recursos del Challenge Lab GSP313.${NC}"
    read -p "$(echo -e ${BOLD}"¿Estás seguro de que deseas continuar? (y/n): "${NC})" CONFIRM

    if [[ "$CONFIRM" != "y" ]]; then
        info "Operación cancelada."
        exit 0
    fi

    info "Iniciando destrucción de la infraestructura..."
    terraform destroy -auto-approve \
        -var="project_id=$PROJECT_ID" \
        -var="region=$REGION" \
        -var="zone=$ZONE"

    if [ $? -eq 0 ]; then
        success "Infraestructura eliminada. El entorno está limpio."
    else
        error "Hubo un problema al eliminar los recursos."
    fi
    exit 0
fi

# 3. Lógica de Despliegue (Default)
info "Entorno: ${BOLD}$PROJECT_ID${NC}"
info "Inicializando Terraform..."
info "Inicializando módulos y plugins..."
# Eliminamos el -quiet para ver qué está pasando si falla
terraform init -input=false > /tmp/tf_init.log 2>&1 &
spinner

# Verificamos si el proceso de fondo terminó con éxito
wait $!
if [ $? -ne 0 ]; then
    echo -e "${RED}Error detectado en la inicialización:${NC}"
    cat /tmp/tf_init.log | grep -i "error" || cat /tmp/tf_init.log
    error "Fallo en 'terraform init'. Asegúrate de estar en la carpeta del blueprint."
fi
success "Terraform listo."

info "Validando configuración..."
terraform validate > /dev/null || error "Validación fallida."

info "Desplegando recursos modulares..."
if terraform apply -auto-approve \
    -var="project_id=$PROJECT_ID" \
    -var="region=$REGION" \
    -var="zone=$ZONE"; then

    echo ""
    success "¡Laboratorio desplegado correctamente!"
    terraform output
else
    error "El despliegue falló."
fi