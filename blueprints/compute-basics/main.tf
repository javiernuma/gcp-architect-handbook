module "virtual-machine" {
  source   = "../../modules/compute/virtual-machine"
  for_each = toset(var.instance_names)

  # Pasamos las variables que el módulo necesita
  project_id    = var.project_id
  instance_name = each.value
  machine_type  = var.machine_type
  zone          = var.zone
  image_family  = var.image_family

  # Red y Seguridad
  subnet_name  = var.subnet_name
  is_public    = var.is_public
  network_tags = var.network_tags # Esto habilita el Firewall para el puerto 80

  # Automatización de NGINX
  # Leemos el script de instalación que creaste en la carpeta del módulo
  startup_script = file("${path.module}/../../modules/compute/virtual-machine/scripts/install-nginx.sh")
}