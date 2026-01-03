output "nginx_url" {
  value       = "http://${module.virtual-machine.external_ip}"
  description = "URL para verificar la instalación de NGINX"
}