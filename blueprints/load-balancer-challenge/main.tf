# TASK 1: Tres instancias web individuales
module "web_servers" {
  source       = "../../modules/compute/instance-template"
  for_each     = toset(var.instance_names)
  name         = "web-server-template"
  machine_type = "e2-small"
  network_tags = ["network-lb-tag"]
  startup_script = templatefile("${path.module}/scripts/install-apache.tftpl", {
    web_number = each.value
  })
}

# TASK 2: Configurar Network Load Balancer
resource "google_compute_address" "network_lb_static_ip" {
  name   = "network-lb-ip-1"
  region = var.region
}

module "network_lb" {
  source     = "../../modules/networking/load-balancer"
  type       = "NETWORK"
  name       = "www-pool"
  region     = var.region
  ip_address = google_compute_address.network_lb_static_ip.address
  instances  = [for vm in module.web_servers : vm.self_link]
}

# TASK 3: Configurar HTTP Load Balancer con MIG
module "lb_template" {
  source         = "../../modules/compute/instance-template"
  name           = "lb-backend-template"
  machine_type   = "e2-medium"
  network_tags   = ["allow-health-check"]
  image_family   = "debian-12"
  startup_script = file("${path.module}/scripts/install-apache.sh")
}

resource "google_compute_instance_group_manager" "lb_mig" {
  name        = "lb-backend-group"
  zone        = var.zone
  target_size = 2

  version {
    instance_template = module.lb_template.self_link
  }
  named_port {
    name = "http"
    port = 80
  }
  base_instance_name = ""
}

resource "google_compute_global_address" "http_lb_static_ip" {
  name = "lb-ipv4-1"
}

resource "google_compute_health_check" "http_basic_check" {
  name = "http-basic-check"

  http_health_check {
    port = 80
  }
}

module "http_lb" {
  source          = "../../modules/networking/load-balancer"
  type            = "HTTP"
  name            = "web-map-http"
  ip_address      = google_compute_global_address.http_lb_static_ip.address
  instance_group  = google_compute_instance_group_manager.lb_mig.instance_group
  health_check_id = google_compute_health_check.http_basic_check.id
}