# blueprints/lab-01-compute-basics/main.tf
module "my_lab_vm" {
  source        = "../../modules/compute/virtual-machine"
  instance_name = "instance-lab-1"
  machine_type  = "e2-medium"
  network_tags  = ["http-server"]
  is_public     = true  # Lo que pide el lab 484532
  startup_script = "apt-get update && apt-get install -y apache2"
}