#!/bin/bash

# --- Configuración de Colores ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

# --- Función de Limpieza (Si el usuario cancela con Ctrl+C) ---
cleanup() {
    echo -e "\n${YELLOW}${BOLD}AVISO:${NC} Proceso interrumpido por el usuario. Limpiando archivos temporales..."
    rm -rf .terraform.lock.hcl 2>/dev/null
    exit 1
}
trap cleanup SIGINT

# --- Funciones de Mensajería ---
info() { echo -e "${BOLD}==>${NC} $@"; }
success() { echo -e "${GREEN}${BOLD}✔️ SUCCESS:${NC} $@"; }
warn() { echo -e "${YELLOW}${BOLD}⚠️ WARNING:${NC} $@"; }
error() {
    echo -e "${RED}${BOLD}❌ ERROR:${NC} $@" >&2
    echo -e "${RED}El despliegue se detuvo. Revisa los mensajes de arriba.${NC}"
    exit 1
}

# --- Función de Spinner ---
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [${YELLOW}%c${NC}]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

clear
echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}${BOLD}   GCP Architect Handbook: GSP313 Deployer   ${NC}"
echo -e "${GREEN}=============================================${NC}"

# 1. Validaciones de Pre-vuelo (Error Handling preventivo)
info "Ejecutando validaciones de pre-vuelo..."

# Verificar si Terraform está instalado
if ! command -v terraform &> /dev/null; then
    error "Terraform no está instalado. Instálalo para continuar."
fi

# Verificar si el archivo de script de inicio existe (ADR-002)
if [[ ! -f "./scripts/install-apache.sh" ]]; then
    error "Archivo critico no encontrado: ./scripts/install-apache.sh"
fi

# 2. Detección de Proyecto y Entorno
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
if [[ -z "$PROJECT_ID" ]]; then
    error "No se pudo detectar el Project ID de GCP. Ejecuta 'gcloud config set project [ID]'."
fi

REGION="us-west3" # Valores por defecto para el lab
ZONE="us-west3-a"

success "Entorno detectado: ${BOLD}$PROJECT_ID${NC}"

# 3. Inicialización de Terraform
info "Inicializando módulos y plugins..."
if ! terraform init -quiet > /tmp/tf_init_err.log 2>&1; then
    cat /tmp/tf_init_err.log
    error "Fallo en 'terraform init'. Revisa los logs anteriores."
fi
success "Terraform listo."

# 4. Validación de Sintaxis
info "Validando coherencia de los Blueprints..."
if ! terraform validate > /dev/null; then
    error "La validación de Terraform falló. Revisa tus archivos .tf"
fi
success "Configuración válida."

# 5. Aplicación con Manejo de Errores en Tiempo de Ejecución
info "Desplegando infraestructura modular..."
echo -e "${YELLOW}Nota: La creación de Load Balancers Globales suele tardar entre 3-5 minutos.${NC}"

# Ejecución y captura de salida
terraform apply -auto-approve \
    -var="project_id=$PROJECT_ID" \
    -var="region=$REGION" \
    -var="zone=$ZONE"

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}=============================================${NC}"
    success "¡Laboratorio GSP313 completado exitosamente!"
    echo -e "${GREEN}=============================================${NC}"
    echo ""
    info "IPs de Balanceo generadas:"
    terraform output
else
    error "La ejecución de Terraform falló durante el despliegue de recursos."
fi