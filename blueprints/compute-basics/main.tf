module "virtualmachine" {
  source = "../../modules/compute/virtual-machine"

  # Pasamos las variables que el módulo necesita
  project_id    = var.project_id
  instance_name = var.instance_name # Nombre específico que pide el lab de Qwiklabs
  machine_type  = var.machine_type
  zone          = var.zone
  image_family  = var.image_family

  # Red y Seguridad
  network_name  = var.network_name
  subnet_name   = var.subnet_name
  is_public     = var.is_public
  network_tags  = var.network_tags # Esto habilita el Firewall para el puerto 80

  # Automatización de NGINX
  # Leemos el script de instalación que creaste en la carpeta del módulo
  startup_script = file("${path.module}/../../modules/compute/virtual-machine/scripts/install-nginx.sh")
}