terraform {
  backend "s3" {
    bucket         = "kubernetes-native-cloud-project-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kubernetes-native-cloud-project-tf-locks"
    encrypt        = true
  }
}
