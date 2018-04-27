provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}

module "region1" {
  source = "../region"

  providers {
    aws = "aws.use1"
  }
}
