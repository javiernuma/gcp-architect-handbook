output "nginx_urls" {
  # Creamos un mapa: "nombre_vm" = "http://ip_publica"
  value = {
    for name, vm in module.virtual-machine : name => "http://${vm.external_ip}"
  }
  description = "URLs de todas las instancias creadas"
}