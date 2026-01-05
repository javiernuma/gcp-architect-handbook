# Blueprint: Implement Load Balancing on Compute Engine (GSP313)

## 🎯 Objetivo
Orquestar una infraestructura híbrida de balanceo de carga en GCP, cumpliendo con los requisitos de networking L4 (Network LB) y L7 (HTTP LB) mediante el uso de módulos reutilizables y el patrón **Blueprints-Core**.

## 🏗️ Arquitectura
Este blueprint automatiza:
1.  **Task 1:** 3 Instancias de VM (web1, web2, web3) con Apache instalados mediante `templatefile`.
2.  **Task 2:** Network Load Balancer (TCP) regional con Target Pool.
3.  **Task 3:** HTTP Load Balancer Global con Managed Instance Group (MIG) y Health Checks.



## 🚀 Guía de Uso en Qwiklabs

### Paso 1: Preparación del entorno
Dentro del Cloud Shell de Qwiklabs, clona tu repositorio (si no lo has hecho) y navega al blueprint:
```bash
cd gcp-architect-handbook/blueprints/load-balancer-challenge
chmod +x deploy.sh
```
---

### 2. Cómo usar esto en el Laboratorio (Paso a paso)

Cuando inicies el cronómetro de Qwiklabs, sigue este flujo para maximizar tu eficiencia:

1.  **Abrir Cloud Shell:** Es tu terminal de mando.
2.  **Clonar tu Repo:**
    ```bash
    git clone https://github.com/javiernuma/gcp-architect-handbook.git
    cd gcp-architect-handbook/blueprints/load-balancer-challenge
    ```
3.  **Configurar Variables:** Terraform necesita el ID del proyecto del lab. Mi script `deploy.sh` lo hace por ti, pero si prefieres hacerlo manual:
    ```bash
    export TF_VAR_project_id=$(gcloud config get-value project)
    terraform init
    terraform apply -auto-approve
    ```
4.  **Check Progress:** Una vez que Terraform termine, ve a la consola de Qwiklabs y haz clic en **"Check my progress"**. Terraform habrá creado los nombres exactos (`web1`, `lb-backend-group`, etc.) que el validador busca.

### 3. Tips de Arquitecto Senior para el Lab

* **El tiempo de propagación:** El HTTP Load Balancer (Task 3) es **Global**. Aunque Terraform termine, GCP tarda unos minutos en configurar los Google Front Ends (GFE). Si el "Check My Progress" falla al principio, espera 2 minutos y vuelve a intentar.
* **Limpieza:** Si por alguna razón te equivocas en un nombre de recurso, no los borres a mano en la consola. Usa `terraform destroy` y vuelve a ejecutar `terraform apply`. Esto mantiene tu "State File" limpio.
* **Costos:** Aunque es un lab, en la vida real, el uso de IPs estáticas (`google_compute_address`) y balanceadores globales consume presupuesto rápidamente. Tu blueprint los gestiona como recursos efímeros.

### 4. Flujo de Git Final
Para que tu repositorio refleje este logro:
```bash
git add .
git commit -m "feat: add blueprint for GSP313 Load Balancing challenge"
git push origin main