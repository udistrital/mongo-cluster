resource "aws_ebs_volume" "data" {
  availability_zone = "${data.aws_region.current.name}${var.suffix}"
  size              = 10
}

resource "aws_ebs_volume" "logs" {
  availability_zone = "${data.aws_region.current.name}${var.suffix}"
  size              = 10
}

resource "aws_volume_attachment" "ebs-attach-data" {
  volume_id   = "${aws_ebs_volume.data.id}"
  instance_id = "${aws_instance.mongo_node.id}"
  device_name = "/dev/sdm"
}

resource "aws_volume_attachment" "ebs-attach-logs" {
  volume_id   = "${aws_ebs_volume.logs.id}"
  instance_id = "${aws_instance.mongo_node.id}"
  device_name = "/dev/sdm"
}
