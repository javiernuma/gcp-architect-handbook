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
    terraform init
    terraform apply -auto-approve
    ```

## 🔍 Validación
Al finalizar, Terraform entregará un mapa de URLs. Acceder a ellas para confirmar la instalación de NGINX.