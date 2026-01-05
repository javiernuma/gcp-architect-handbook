#!/bin/bash

# Función de Spinner para feedback visual
spinner() {
    local pid=$!
    local delay=0.15
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

echo "============================================="
echo "   GCP Architect Handbook: GSP313 Deployer   "
echo "============================================="

# 1. Detección de Entorno
echo -n "Detectando configuración de GCP... "
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])" 2>/dev/null)
ZONE=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-zone])" 2>/dev/null)
spinner
echo "OK"

# Fallback para variables si no están en metadata
[[ -z "$REGION" ]] && REGION="us-west3"
[[ -z "$ZONE" ]] && ZONE="us-west3-a"

# 2. Preparación de Terraform
echo -n "Inicializando Terraform... "
terraform init -quiet > /dev/null 2>&1 &
spinner
echo "Done"

# 3. Aplicación de Infraestructura Modular
echo "Desplegando infraestructura (Módulos: VM, Instance Template, Load Balancers)..."
echo "Esto puede tardar de 3 a 5 minutos debido al HTTP Global LB."

terraform apply -auto-approve \
  -var="project_id=$PROJECT_ID" \
  -var="region=$REGION" \
  -var="zone=$ZONE" &
spinner

echo ""
echo "============================================="
echo "   ¡Despliegue Completado Exitosamente!      "
echo "============================================="
terraform output