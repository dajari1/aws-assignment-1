terraform {
  backend "s3" {
    bucket = "assignment-9911"
    region = "us-east-1"
    key    = "infra-backend-101/terraform.tfstate"
  }
}