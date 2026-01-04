# --- NETWORK LOAD BALANCER (L4) ---
resource "google_compute_target_pool" "l4_pool" {
  count     = var.type == "NETWORK" ? 1 : 0
  name      = "${var.name}-pool"
  region    = var.region
  instances = var.instances
}

resource "google_compute_forwarding_rule" "l4_forwarding" {
  count      = var.type == "NETWORK" ? 1 : 0
  name       = "${var.name}-forwarding"
  region     = var.region
  port_range = "80"
  target     = google_compute_target_pool.l4_pool[0].id
}

# --- HTTP LOAD BALANCER (L7) ---
resource "google_compute_global_forwarding_rule" "l7_forwarding" {
  count      = var.type == "HTTP" ? 1 : 0
  name       = "${var.name}-http-forwarding"
  target     = google_compute_target_http_proxy.l7_proxy[0].id
  port_range = "80"
  ip_address = var.ip_address
}

resource "google_compute_target_http_proxy" "l7_proxy" {
  count   = var.type == "HTTP" ? 1 : 0
  name    = "${var.name}-target-proxy"
  url_map = google_compute_url_map.l7_map[0].id
}

resource "google_compute_url_map" "l7_map" {
  count           = var.type == "HTTP" ? 1 : 0
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.l7_backend[0].id
}

resource "google_compute_backend_service" "l7_backend" {
  count         = var.type == "HTTP" ? 1 : 0
  name          = "${var.name}-backend"
  protocol      = "HTTP"
  health_checks = [var.health_check_id]
  backend {
    group = var.instance_group
  }
}