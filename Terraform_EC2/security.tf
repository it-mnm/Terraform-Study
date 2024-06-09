resource "aws_security_group" "project1_sg" {
  name_prefix = "project1-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "project1_sg_ingress_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project1_sg.id
}

resource "aws_security_group_rule" "project1_sg_ingress_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project1_sg.id
}

resource "aws_security_group_rule" "project1_sg_egress_all" {
  type             = "egress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project1_sg.id
}