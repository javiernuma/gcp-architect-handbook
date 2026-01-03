output "instance_name" {
  value = google_compute_instance.vm_instance.name
}
output "external_ip" {
  # Asegúrate de que el nombre después del punto coincida con el nombre en tu main.tf
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "IP pública de la instancia"
}