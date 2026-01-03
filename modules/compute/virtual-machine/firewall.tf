resource "google_compute_firewall" "allow_http" {
  name    = "${var.instance_name}-allow-http"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # Esta regla solo se aplica a las VMs que tengan este tag
  target_tags   = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}