resource "aws_instance" "mongo_node" {
  ami                     = "ami-f973ab84"
  instance_type           = "t2.micro"
  subnet_id               = "${local.subnets[var.suffix]}"
  vpc_security_group_ids  = ["${var.security_group_id}"]
  disable_api_termination = true

  tags {
    Name = "Nodo ${var.suffix}"
  }
}
