terraform {
  required_version = "~> 0"

  backend "s3" {
    bucket                      = "oas-terraform-tfstate"
    key                         = "mongo-cluster.tfstate"
    region                      = "us-east-1"
    dynamodb_table              = "terraform"
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}
