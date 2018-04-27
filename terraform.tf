terraform {
  required_version = "~> 0"

  backend "s3" {
    bucket         = "oas-terraform-tfstate"
    key            = "mongo-cluster.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform"
  }
}
