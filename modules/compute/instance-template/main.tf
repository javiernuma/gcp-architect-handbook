resource "google_compute_instance_template" "this" {
  name_prefix  = "${var.name}-"
  machine_type = var.machine_type
  tags         = var.network_tags

  disk {
    source_image = var.image_family
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network_name
  }

  metadata_startup_script = var.startup_script

  lifecycle {
    create_before_destroy = true
  }
}
