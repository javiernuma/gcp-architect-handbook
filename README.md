# GCP Professional Architect Handbook 🚀
### *Enterprise Patterns: From Lab Validation to Production-Ready Solutions*

[![GCP Certification](https://img.shields.io/badge/Google_Cloud-Professional_Architect-blue?logo=google-cloud&logoColor=white)](https://www.credly.com/)
[![IaC: Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Architecture: Multi-SaaS](https://img.shields.io/badge/Focus-Multi--SaaS-green)](#)

![Validate](https://github.com/javiernuma/gcp-architect-handbook/actions/workflows/terraform-validate.yml/badge.svg)

# GCP Architect Handbook
Manual de infraestructura como código para **DSION Group**.

## 📌 Overview
Este repositorio es un compendio de **patrones de arquitectura, infraestructura como código (IaC) y decisiones técnicas**. Representa la síntesis entre la preparación para la certificación *GCP Professional Cloud Architect* y la resolución de desafíos complejos en infraestructuras **Multi-SaaS empresariales**.

A diferencia de un repositorio de aprendizaje convencional, aquí cada solución ha sido:
1.  **Validada:** En entornos sandbox de Google Skillboost.
2.  **Modularizada:** Abstraída en módulos de Terraform siguiendo principios de *Don't Repeat Yourself* (DRY).
3.  **Justificada:** Mediante ADRs (Architecture Decision Records) que explican el razonamiento detrás de cada elección tecnológica frente a alternativas del mercado.
---

## 🏗️ Core Architecture Pillars

### 1. Networking & Security (Zero Trust focus)
* **Hierarchical Firewalls:** Estructura de seguridad para entornos con múltiples capas de aislamiento.
* **Private Service Connect:** Conectividad privada para servicios SaaS, evitando el peering de VPC tradicional para mayor escalabilidad.
* **Hub & Spoke Topology:** Implementación de Shared VPCs para separar servicios core de aplicaciones de tenants.
* **Internal Load Balancing:** Patrones para comunicación interna segura (East-West traffic) sin exposición a IPs públicas.
* **Cloud Armor & WAF:** Políticas de filtrado de Capa 7 para mitigar SQLi y XSS en aplicaciones SaaS.



### 2. Scalable Compute & Multi-Tenancy
Estrategias de despliegue para cargas de trabajo dinámicas.
* **GKE Multi-Tenant Clusters:** Aislamiento mediante *Namespaces*, *Network Policies* y *Workload Identity*.
* **Serverless Scaffolding:** Plantillas para Cloud Run escalables con balanceo de carga global (HTTPS LB).

### 3. Data Residency & Integrity
Gestión de persistencia para arquitecturas distribuidas.
* **Multi-Region Cloud SQL:** Configuración para alta disponibilidad global y replicación asíncrona.
* **Fencing Token Patterns:** Implementación de patrones de integridad para evitar escrituras concurrentes conflictivas en sistemas distribuidos.

---

## 📂 Project Structure

```bash
.
├── adr/                   # Architecture Decision Records (The "Why")
├── design/                # High-level diagrams (Mermaid.js / Lucidchart)
├── modules/               # Reusable Terraform modules (The "How")
│   ├── networking/        # VPC, Subnets, Firewalls, Cloud NAT
│   ├── compute/           # GKE Autopilot, Cloud Run, MIGs
│   └── security/          # IAM Custom Roles, KMS, Cloud Armor
└── blueprints/            # Full-stack solutions based on Skillboost labs
    ├── global-lb-backend/ # Global HTTPS LB + Cloud Armor + Cloud Run
    └── internal-micro-svc/# Private ILB + Managed Instance Groups
