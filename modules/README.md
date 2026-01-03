# 📦 Librería de Módulos Core

Esta carpeta contiene componentes de infraestructura **reutilizables, versionados y agnósticos** al entorno. Siguiendo el principio **DRY (Don't Repeat Yourself)**, estos módulos son consumidos por los Blueprints para construir arquitecturas complejas.

## 🛠️ Organización de Módulos

Los módulos están categorizados por el tipo de servicio de Google Cloud:

* **[Compute](./compute/virtual-machine)**: Instancias de GCE, grupos de instancias (MIGs) y plantillas de GKE.
* **Networking (Próximamente)**: Configuración de VPCs, Cloud NAT y Firewalls.
* **Security (Próximamente)**: Gestión de identidades (IAM), KMS y Secret Manager.

## 📏 Estándares de Desarrollo
1.  **Variables Obligatorias**: Todo módulo debe solicitar `project_id`.
2.  **Documentación**: Cada submódulo debe tener su propio README detallando entradas (`inputs`) y salidas (`outputs`).
3.  **Formato**: El código debe estar formateado con `terraform fmt`.

---
[⬅️ Volver al Inicio](../README.md)