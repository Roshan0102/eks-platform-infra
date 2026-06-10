terraform {
  backend "s3" {
    bucket         = "kncp-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kncp-tf-locks"
    encrypt        = true
  }
}
