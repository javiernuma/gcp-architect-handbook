resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name # <-- Usa la variable
  machine_type = var.machine_type  # <-- Usa la variable
  zone         = var.zone          # <-- Usa la variable
  tags         = var.network_tags  # <-- Usa la variable

  boot_disk {
    initialize_params {
      image = var.image_family # <-- Usa la variable
    }
  }

  network_interface {
    network    = var.network_name # <-- Usa la variable
    subnetwork = var.subnet_name  # <-- Usa la variable

    dynamic "access_config" {
      for_each = var.is_public ? [1] : []
      content {}
    }
  }
  metadata_startup_script = file("${path.module}/scripts/install-nginx.sh")
}