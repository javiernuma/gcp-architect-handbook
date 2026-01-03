# ADR 001: Implementación de Patrón Módulos-Blueprints para Infraestructura Multi-SaaS

**Estado:** Aceptado  
**Fecha:** 2026-01-02  
**Autor:** Javier Numa

## 1. Contexto
En el diseño de arquitecturas empresariales para plataformas Multi-SaaS, la escalabilidad y la consistencia entre entornos (Development, Staging, Production) son críticas. El despliegue de recursos de infraestructura (Compute, Networking, Database) tiende a volverse propenso a errores si se gestiona de forma monolítica o manual, especialmente cuando se deben replicar configuraciones similares para diferentes inquilinos (Tenants).

## 2. Problema
¿Cómo podemos garantizar que la infraestructura sea reutilizable, fácil de auditar y consistente, minimizando la duplicación de código y permitiendo que diferentes proyectos consuman estándares de seguridad pre-aprobados?

## 3. Decisiones
Se ha decidido implementar un patrón de diseño en Terraform basado en la separación de **Módulos** y **Blueprints**:

1.  **Módulos (Core Library):** Ubicados en `/modules`, actúan como plantillas agnósticas al entorno. Definen el "qué" y el "cómo" siguiendo las mejores prácticas de Google Cloud (ej. seguridad por defecto, etiquetado obligatorio).
2.  **Blueprints (Implementaciones):** Ubicados en `/blueprints`, representan casos de uso específicos o entornos. Invocan a los módulos e inyectan las variables necesarias para el contexto (Project IDs, Regiones, Machine Types).

## 4. Alternativas Consideradas
* **Código Monolítico (Root-heavy):** Definir todos los recursos en un solo lugar. *Descartado* por baja reutilización y riesgo de "Blast Radius" elevado.
* **Terraform Workspaces:** Útil para replicar entornos idénticos. *Descartado* como solución única, ya que no resuelve la necesidad de abstracción de componentes complejos.

## 5. Consecuencias

### Positivas:
* **Principio DRY (Don't Repeat Yourself):** Reducción drástica de la duplicación de código.
* **Gobernanza:** Los cambios en un módulo (ej. una actualización de seguridad en el firewall) se propagan a todos los blueprints que lo consumen.
* **Velocidad de Despliegue:** La creación de un nuevo entorno para un tenant se reduce a la creación de un nuevo blueprint que invoque módulos existentes.

### Negativas:
* **Complejidad Inicial:** Requiere un entendimiento profundo del paso de variables y dependencias entre módulos.
* **Mantenimiento de Versiones:** Los cambios en módulos core deben ser testeados rigurosamente para no romper blueprints existentes (Versioning).

## 6. Referencias
* [Google Cloud: Best practices for using Terraform](https://cloud.google.com/docs/terraform/best-practices-for-terraform)