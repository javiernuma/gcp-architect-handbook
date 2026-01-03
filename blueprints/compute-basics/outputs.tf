output "external_ip" {
  # Asegúrate de que el nombre después del punto coincida con el nombre en tu main.tf
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "IP pública de la instancia"
}

output "instance_name" {
  value = google_compute_instance.vm_instance.name
}

output "nginx_url" {
  value       = "http://${google_compute_instance.vm_instance.external_ip}"
  description = "Copia y pega esta URL en tu navegador para verificar NGINX"
}