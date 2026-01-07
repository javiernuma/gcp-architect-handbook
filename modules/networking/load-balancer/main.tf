# --- NETWORK LOAD BALANCER (L4) ---
resource "google_compute_http_health_check" "basic_check" {
  name = "basic-check"
}

resource "google_compute_target_pool" "l4_pool" {
  count     = var.type == "NETWORK" ? 1 : 0
  name      = "www-pool" # Nombre exacto Task 2
  region    = var.region
  instances = var.instances
  health_checks = [google_compute_http_health_check.basic_check.name]
}

resource "google_compute_forwarding_rule" "l4_forwarding" {
  count      = var.type == "NETWORK" ? 1 : 0
  name       = "www-rule" # Nombre estándar para el reenvío L4
  region     = var.region
  port_range = "80"
  target     = google_compute_target_pool.l4_pool[0].id
  ip_address = var.ip_address # Usa la IP estática creada en el blueprint
}

# --- HTTP LOAD BALANCER (L7) ---
resource "google_compute_global_forwarding_rule" "l7_forwarding" {
  count      = var.type == "HTTP" ? 1 : 0
  name       = "http-content-rule" # Nombre común en este lab
  target     = google_compute_target_http_proxy.l7_proxy[0].id
  port_range = "80"
  ip_address = var.ip_address
}

resource "google_compute_target_http_proxy" "l7_proxy" {
  count   = var.type == "HTTP" ? 1 : 0
  name    = "http-lb-proxy" # REQUERIDO: Nombre exacto Task 3
  url_map = google_compute_url_map.l7_map[0].id
}

resource "google_compute_url_map" "l7_map" {
  count           = var.type == "HTTP" ? 1 : 0
  name            = "web-map-http" # REQUERIDO: Nombre exacto Task 3
  default_service = google_compute_backend_service.l7_backend[0].id
}

resource "google_compute_backend_service" "l7_backend" {
  count         = var.type == "HTTP" ? 1 : 0
  name          = "web-backend-service" # Nombre descriptivo para el backend
  protocol      = "HTTP"
  port_name     = "http"
  health_checks = [var.health_check_id]
  backend {
    group = var.instance_group
  }
}