variable "security_group_id" {}

variable "suffix" {}

data "aws_region" current {}

locals {
  subnets {
    a = "subnet-af1c7385"
    b = "subnet-7f8fd109"
    c = "subnet-457a0f1d"
  }
}
