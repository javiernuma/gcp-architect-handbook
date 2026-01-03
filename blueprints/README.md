# 🏗️ Catalog of Infrastructure Blueprints

Esta carpeta contiene soluciones *end-to-end* que orquestan los módulos internos para resolver escenarios específicos de Google Cloud.

## 📋 Índice de Escenarios



| Laboratorio | Título | Módulos Utilizados | Dificultad |
| :--- | :--- | :--- | :--- |
| **L01** | [Compute Basics](./compute-basics) | `compute/virtual-machine` | 🟢 Fácil |
| **L02** | [Networking Hub](./networking-basics) | `networking/vpc`, `networking/firewall` | 🟡 Media |
| **L03** | [Global Load Balancing](./global-lb) | `compute/mig`, `networking/lb` | 🔴 Alta |

## ⚙️ Instrucciones Globales
Todos los blueprints requieren un archivo `terraform.tfvars` basado en el `terraform.tfvars.example` provisto en cada subcarpeta.


```bash
# Flujo estándar de ejecución
terraform init
terraform plan -out=plan.tfplan
terraform apply "plan.tfplan"
```
---
[⬅️ Volver al Inicio](../README.md)