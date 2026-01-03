# Invocamos el módulo de VM que definimos en la carpeta modules
module "lab_vm" {
  source = "../../modules/compute/virtual-machine"

  # Pasamos las variables requeridas por el módulo
  project_id    = var.project_id
  instance_name = "instance-lab-01"
  machine_type  = "e2-medium"
  zone          = var.zone

  # Network Tags: Vital para seguridad y Load Balancing posterior
  network_tags = ["http-server", "lb-backend"]

  # El Lab 484532 pide una VM con IP pública
  is_public = true

  # Sistema operativo solicitado en el Lab
  image_family = "debian-cloud/debian-11"

  # Pasamos el ID de la red y subred (usando la default por ahora)
  network_name = "default"
  subnet_name  = "default"
}