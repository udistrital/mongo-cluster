resource "aws_security_group" "mongo_sg" {
  name        = "mongo_sg"
  description = "Permitir trafico para nodos de mongoDB"
  vpc_id      = "${local.vpc_id}"
}

resource "aws_security_group_rule" "sgr_ingress_aps1" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = "${local.security_groups_id[0]}"
  security_group_id        = "${aws_security_group.mongo_sg.id}"
}

resource "aws_security_group_rule" "sgr_egress_aps1" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${local.security_groups_id[0]}"
  security_group_id        = "${aws_security_group.mongo_sg.id}"
}

resource "aws_security_group_rule" "sgr_ingress_aps2" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = "${local.security_groups_id[1]}"
  security_group_id        = "${aws_security_group.mongo_sg.id}"
}

resource "aws_security_group_rule" "sgr_egress_aps2" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${local.security_groups_id[1]}"
  security_group_id        = "${aws_security_group.mongo_sg.id}"
}

resource "aws_security_group_rule" "sgr_ingress_self" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  self              = true
  security_group_id = "${aws_security_group.mongo_sg.id}"
}

resource "aws_security_group_rule" "sgr_egress_self" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.mongo_sg.id}"
}
