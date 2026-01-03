output "instance_name" {
  value = google_compute_instance.vm_instance.name
}
output "external_ip" {
  # Usamos try para que si la lista está vacía, devuelva un string vacío en lugar de un error crítico
  value       = try(google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip, "")
  description = "IP pública de la instancia (si existe)"
}