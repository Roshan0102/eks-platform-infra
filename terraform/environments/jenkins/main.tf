module "jenkins" {
  source = "../../modules/jenkins"

  project_name = "kncp"

  instance_type = "m7i-flex.large"

  key_name = var.key_name
}