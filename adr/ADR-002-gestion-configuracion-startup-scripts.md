# ADR 002: Gestión de Configuración mediante Startup Scripts

## Estado
Aceptado

## Contexto
Para el despliegue de aplicaciones en Compute Engine (como NGINX en el Lab 01), existen tres alternativas principales:
1.  **Imágenes personalizadas (Golden Images):** Crear una imagen de disco con todo preinstalado.
2.  **Herramientas de gestión de configuración:** Uso de Ansible, Chef o Puppet.
3.  **Scripts de inicio (Startup Scripts):** Scripts de Bash ejecutados por el agente de Google al arrancar la VM.

## Decisión
Hemos optado por el uso de **Startup Scripts** inyectados a través de Terraform para las fases iniciales y laboratorios de validación.



## Razonamiento
* **Agilidad:** Permite modificar la configuración del software (versiones de NGINX, contenido web) sin tener que recrear imágenes de disco pesadas.
* **Transparencia en el código:** El script reside en el repositorio (`modules/compute/virtual-machine/scripts/`), lo que permite que cualquier arquitecto vea exactamente qué se está instalando sin salir de GitHub.
* **Costo:** Evita el almacenamiento y mantenimiento de múltiples imágenes personalizadas en el registro de GCP.
* **Compatibilidad con Terraform:** La función `file()` de Terraform facilita la inyección de estos scripts de forma limpia y modular.

## Consecuencias
* **Positivas:** Despliegues rápidos y documentación de la configuración directamente en el código de infraestructura.
* **Negativas:** El tiempo de "boot" de la instancia es ligeramente mayor, ya que debe descargar e instalar paquetes en cada arranque. Para entornos de auto-escalado masivo en producción, se recomienda evolucionar hacia *Golden Images* o contenedores.