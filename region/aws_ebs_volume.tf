data "aws_region" current {}

resource "aws_ebs_volume" "ebs1" {
  availability_zone = "${data.aws_region.current.name}a"
  size              = 10
}

resource "aws_ebs_volume" "ebs2" {
  availability_zone = "${data.aws_region.current.name}c"
  size              = 10
}
