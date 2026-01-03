module "lab_vm" {
  source        = "../../modules/compute/virtual-machine" # Ruta relativa al módulo
  project_id    = var.project_id
  instance_name = "instance-lab-1"
  machine_type  = "e2-medium"
  zone          = "us-central1-a"
  network_tags  = ["http-server"]
  is_public     = true # El lab pide que sea accesible por IP externa
  image_family  = "debian-cloud/debian-11"
}