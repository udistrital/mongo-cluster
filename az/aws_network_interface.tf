locals {
  subnets {
    a = "subnet-af1c7385"
    b = "subnet-7f8fd109"
    c = "subnet-457a0f1d"
  }
}

resource "aws_network_interface" "iface" {
  subnet_id = "${local.subnets[var.suffix]}"
}
