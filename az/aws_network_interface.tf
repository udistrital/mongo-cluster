resource "aws_network_interface" "iface" {
  subnet_id = "${local.subnets[var.suffix]}"

  attachment {
    instance     = "${aws_instance.mongo_node.id}"
    device_index = 1
  }
}
