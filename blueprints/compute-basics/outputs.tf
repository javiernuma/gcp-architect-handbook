output "nginx_url" {
  value       = "http://${module.virtualmachine.external_ip}"
  description = "URL para verificar la instalación de NGINX"
}