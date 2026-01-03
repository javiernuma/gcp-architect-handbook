resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = var.image_family
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    dynamic "access_config" {
      for_each = var.is_public ? [1] : []
      content {}
    }
  }

  metadata_startup_script = var.startup_script
}