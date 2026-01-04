output "network_lb_url" {
  description = "URL del Network Load Balancer"
  value       = "http://${module.network_lb.lb_ip}"
}

output "http_lb_url" {
  description = "URL del HTTP Load Balancer Global"
  value       = "http://${module.http_lb.lb_ip}"
}
# IPs de las instancias individuales para verificar con curl (Task 1)
output "individual_vm_ips" {
  value = {
    for name, vm in module.web_servers : name => vm.instance_external_ip
  }
}
