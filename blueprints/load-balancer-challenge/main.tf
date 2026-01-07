# ==========================================================
# TASK 1: INSTANCIAS STANDALONE (Módulo Virtual Machine)
# ==========================================================
# 1. Dirección IP Global Estática
resource "google_compute_global_address" "http_lb_ip" {
  name = "lb-ipv4-1"
}

# Despliegue dinámico de web1, web2, web3
module "web_servers" {
  source   = "../../modules/compute/virtual-machine"
  for_each = toset(["web1", "web2", "web3"])

  project_id    = var.project_id
  instance_name = each.value
  machine_type  = "e2-small"
  zone          = var.zone
  image_family  = "debian-12"

  network_tags = ["network-lb-tag"]
  is_public    = true

  # ADR-002: Inyección de script dinámico usando templatefile
  startup_script = templatefile("${path.module}/scripts/install-apache.tftpl", {
    web_number = each.value
  })
}

# ==========================================================
# TASK 2: NETWORK LOAD BALANCER (Utilizando tu Módulo L4)
# ==========================================================

resource "google_compute_address" "network_lb_ip" {
  name   = "network-lb-ip-1"
  region = var.region
}

# Crea el Pool y la Forwarding Rule condicionalmente [cite: 71, 72]
module "network_lb" {
  source     = "../../modules/networking/load-balancer"
  type       = "NETWORK"
  name       = "www"
  region     = var.region
  ip_address = google_compute_address.network_lb_ip.address
  # Referencia dinámica a los self_links de las VMs creadas [cite: 78]
  instances = [for vm in module.web_servers : vm.self_link]
}

# ==========================================================
# TASK 3: HTTP LOAD BALANCER (Utilizando tu Módulo L7)
# ==========================================================

# 1. Template para el Managed Instance Group
module "lb_template" {
  source         = "../../modules/compute/instance-template"
  name           = "lb-backend-template"
  machine_type   = "e2-medium"
  network_tags   = ["allow-health-check"]
  image_family   = "debian-12"
  startup_script = file("${path.module}/scripts/install-apache.sh")
}

# 2. Managed Instance Group (MIG)
resource "google_compute_instance_group_manager" "lb_backend_group" {
  name               = "lb-backend-group"
  zone               = var.zone
  base_instance_name = "web"
  target_size        = 2

  version {
    instance_template = module.lb_template.self_link
  }

  named_port {
    name = "http"
    port = 80
  }
}


# Health Check requerido para el Backend Service [cite: 76]
resource "google_compute_health_check" "http_basic_check" {
  name = "http-basic-check"
  http_health_check {
    port = 80
  }
}

# Crea el stack L7 condicionalmente: Backend, URL Map, Proxy y Forwarding Rule [cite: 73, 74, 75, 76]
module "http_lb" {
  source          = "../../modules/networking/load-balancer"
  type            = "HTTP"
  name            = "web-map-http"
  ip_address      = google_compute_global_address.http_lb_ip.address
  instance_group  = google_compute_instance_group_manager.lb_backend_group.instance_group
  health_check_id = google_compute_health_check.http_basic_check.id
}

