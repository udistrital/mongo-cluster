variable "suffix" {}

data "aws_region" current {}

resource "aws_ebs_volume" "data" {
  availability_zone = "${data.aws_region.current.name}${var.suffix}"
  size              = 10
}

resource "aws_ebs_volume" "logs" {
  availability_zone = "${data.aws_region.current.name}${var.suffix}"
  size              = 10
}
