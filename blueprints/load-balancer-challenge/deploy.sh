#!/bin/bash

# =============================================================
# GCP Architect Handbook: Lifecycle Management Tool
# Blueprint: GSP313 Challenge Lab
# =============================================================

# --- Configuración de Colores (ANSI) ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

# --- Funciones de Mensajería Semántica ---
info() { echo -e "${BOLD}==>${NC} $@"; }
success() { echo -e "${GREEN}${BOLD}✔️ SUCCESS:${NC} $@"; }
warn() { echo -e "${YELLOW}${BOLD}⚠️ WARNING:${NC} $@"; }
error() {
    echo -e "${RED}${BOLD}❌ ERROR:${NC} $@" >&2
    echo -e "${RED}El proceso se detuvo. Revisa los mensajes anteriores.${NC}"
    exit 1
}

# --- Función de Limpieza (Trap) ---
cleanup() {
    echo -e "\n${YELLOW}${BOLD}AVISO:${NC} Proceso interrumpido. Limpiando..."
    exit 1
}
trap cleanup SIGINT

# --- Detección de Parámetros ---
ACTION="apply"
if [[ "$1" == "--destroy" ]]; then
    ACTION="destroy"
fi

clear
echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}${BOLD}   GCP Architect Handbook: GSP313 Deployer   ${NC}"
echo -e "${GREEN}=============================================${NC}"

# 1. Pre-vuelo: Detección de Proyecto y Variables
info "Configurando entorno de GCP..."
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])" 2>/dev/null)
ZONE=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-zone])" 2>/dev/null)

# Fallback para Laboratorio
[[ -z "$PROJECT_ID" ]] && error "No se detectó Project ID. Usa 'gcloud config set project'."
[[ -z "$REGION" ]] && REGION="us-west3"
[[ -z "$ZONE" ]] && ZONE="us-west3-b"

success "Proyecto: ${BOLD}$PROJECT_ID${NC} | Región: ${BOLD}$REGION${NC}"

# 2. Lógica de Destrucción
if [[ "$ACTION" == "destroy" ]]; then
    echo -e "${YELLOW}${BOLD}❗ PELIGRO:${NC}"
    echo -e "${YELLOW}Vas a eliminar toda la infraestructura del desafío.${NC}"
    read -p "$(echo -e ${BOLD}"¿Confirmar destrucción? (y/n): "${NC})" CONFIRM
    if [[ "$CONFIRM" == "y" ]]; then
        info "Destruyendo recursos..."
        terraform destroy -auto-approve -var="project_id=$PROJECT_ID" -var="region=$REGION" -var="zone=$ZONE"
        [[ $? -eq 0 ]] && success "Infraestructura eliminada." || error "Fallo al destruir."
    else
        info "Operación cancelada."
    fi
    exit 0
fi

# 3. Inicialización de Terraform (Versión Robusta)
info "Inicializando Terraform..."
# Ejecución directa para evitar errores de buffer en Cloud Shell
terraform init -input=false
if [ $? -ne 0 ]; then
    error "Fallo en 'terraform init'. Asegúrate de estar en la carpeta del blueprint."
fi

# 4. Validación de Blueprints
info "Validando sintaxis y módulos..."
if ! terraform validate; then
    error "La validación falló. Revisa tus archivos .tf"
fi
success "Configuración válida."

# 5. Despliegue de Infraestructura
info "Aplicando cambios en Google Cloud..."
warn "La creación de Load Balancers puede tomar hasta 5 minutos."

# Capturamos la salida para manejo de errores
terraform apply -auto-approve \
    -var="project_id=$PROJECT_ID" \
    -var="region=$REGION" \
    -var="zone=$ZONE"

# 6. Resultado Final
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}=============================================${NC}"
    success "¡Despliegue completado con éxito!"
    echo -e "${GREEN}=============================================${NC}"
    echo ""
    info "IPs finales para validar en el Lab:"
    terraform output
else
    error "Terraform apply falló durante la creación de recursos."
fi