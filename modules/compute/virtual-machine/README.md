# Module: Virtual Machine (Compute Engine)

## 📌 Descripción
Este módulo automatiza la creación de instancias de Google Compute Engine (GCE) con un enfoque en la reutilización y la seguridad. Permite desplegar instancias simples o múltiples utilizando patrones declarativos.

## 🚀 Características
- **Dual Network Access**: Soporte para IPs públicas efímeras mediante bloques dinámicos.
- **Bootstrapping**: Integración nativa con scripts de inicio (`startup-script`).
- **Standardized Tagging**: Implementación de etiquetas para gestión de Firewalls y auditoría.

## 📥 Inputs (Variables)
| Nombre | Descripción | Tipo | Default |
| :--- | :--- | :--- | :--- |
| `project_id` | ID del proyecto de GCP | `string` | n/a |
| `instance_name` | Nombre base de la instancia | `string` | n/a |
| `machine_type` | Tipo de máquina (e.g., e2-medium) | `string` | `"e2-micro"` |
| `is_public` | Define si la VM tendrá acceso directo a internet | `bool` | `false` |
| `startup_script` | Script de bash para ejecutar al inicio | `string` | `""` |

## 📤 Outputs
- `external_ip`: Devuelve la dirección IP pública asignada (si `is_public` es true).