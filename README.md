# GCP Professional Architect Handbook 🚀
### *From Cloud Skills Boost to Production-Ready Solutions*

[![GCP Certification](https://img.shields.io/badge/Google_Cloud-Professional_Architect-blue?logo=google-cloud&logoColor=white)](https://www.credly.com/)
[![IaC: Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Architecture: Multi-SaaS](https://img.shields.io/badge/Focus-Multi--SaaS-green)](#)

## 📌 Overview
Este repositorio es un compendio de **patrones de arquitectura, infraestructura como código (IaC) y decisiones técnicas** desarrolladas durante mi preparación para la certificación *GCP Professional Cloud Architect* y mi experiencia real liderando el proyecto **Multi-SaaS en DSION Group**.

A diferencia de un repositorio de aprendizaje convencional, aquí cada solución ha sido:
1.  **Validada** en entornos sandbox de Google Skillboost.
2.  **Abstraída** en módulos de Terraform reutilizables.
3.  **Documentada** mediante ADRs (Architecture Decision Records) para justificar su viabilidad en producción.

---

## 🏗️ Core Architecture Pillars

### 1. Networking & Security (Zero Trust focus)
Diseños orientados a la seguridad perimetral y aislamiento de inquilinos (Tenants).
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
