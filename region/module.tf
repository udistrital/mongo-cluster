locals {
  vpc_id             = "vpc-4878832f"
  security_groups_id = ["sg-13acad68", "sg-55d4c42e"]
}

module "az1" {
  source            = "../az"
  suffix            = "a"
  security_group_id = "${aws_security_group.mongo_sg.id}"
}

module "az2" {
  source            = "../az"
  suffix            = "b"
  security_group_id = "${aws_security_group.mongo_sg.id}"
}

module "az3" {
  source            = "../az"
  suffix            = "c"
  security_group_id = "${aws_security_group.mongo_sg.id}"
}
