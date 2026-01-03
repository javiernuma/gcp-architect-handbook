output "instance_name" {
  value = google_compute_instance.vm_instance.name
}

output "nginx_url" {
  value       = "http://${google_compute_instance.vm_instance.external_ip}"
  description = "Copia y pega esta URL en tu navegador para verificar NGINX"
}