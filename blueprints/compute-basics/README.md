# Blueprint: Compute Basics (Skillboost Lab 01)

## 🎯 Objetivo
Desplegar una arquitectura de servidor web básica pero profesional, separando la infraestructura de la configuración del software.

## 🧩 Componentes Utilizados
1.  **Módulo Core**: `modules/compute/virtual-machine`
2.  **Scripts**: `install-nginx.sh` para la automatización de la capa de aplicación.
3.  **Firewall**: Reglas basadas en etiquetas (`http-server`).

## 🛠️ Ejecución en Laboratorio
1.  Obtener el `Project ID` de la consola de Qwiklabs.
2.  Configurar `terraform.tfvars`:
    ```hcl
    project_id     = "TU_PROJECT_ID"
    instance_names = ["gcplab", "gcelab2"]
    ```
3.  Desplegar:
    ```bash
    # 1. Configura el proyecto actual de Qwiklabs
    gcloud config set project $(gcloud config get-value project)
    # 2. Clona tu repositorio (usa tu URL de GitHub)
    git clone https://github.com/javiernuma/gcp-architect-handbook.git
    cd gcp-architect-handbook/blueprints/compute-basics
    # 3 crear eñ archivo terraform.tfvars
    cat <<EOF > terraform.tfvars
     # variables terraform.tfvars.example
    EOF
    # 4 ejecutar 
    terraform init
    terraform apply -auto-approve
    ```

## 🔍 Validación
Al finalizar, Terraform entregará un mapa de URLs. Acceder a ellas para confirmar la instalación de NGINX.