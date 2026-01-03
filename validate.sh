#!/bin/bash
# validate.sh - Control de Calidad para el Handbook
# chmod +x validate.sh otorgar permisos solo la primera vez

# Colores para la terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🎨 Formateando archivos de Terraform...${NC}"
terraform fmt -recursive

echo -e "${GREEN}🔍 Iniciando validación de Blueprints...${NC}"

# Buscamos todas las carpetas dentro de blueprints que tengan archivos .tf
for d in $(find blueprints -maxdepth 2 -name "*.tf" -exec dirname {} \; | sort -u); do
    echo -n "Validando $d... "
    # Ejecutamos init y validate en silencio
    (cd "$d" && terraform init -backend=false -upgrade=false > /dev/null 2>&1 && terraform validate > /dev/null 2>&1)

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}ERROR${NC}"
        # Si falla, mostramos el error real para debuguear
        (cd "$d" && terraform validate)
        exit 1
    fi
done

echo -e "\n${GREEN}✅ ¡Estructura validada! Ya puedes hacer git push.${NC}"