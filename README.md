# Terraform_EC2
---
프로젝트1을 위한 Terraform 구성
```
#ec2.tf
provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "project1" {
  ami                          = "ami-0e6f2b2fa0ca704d0"
  instance_type                = "t2.micro"
  key_name                     = aws_key_pair.project1_make_keypair.key_name
  vpc_security_group_ids       = [aws_security_group.project1_sg.id]
  associate_public_ip_address  = true
  
  tags = {
    Name = "project1"
  }
}
```
설명: Project1을 위한 EC2 인스턴스를 설정합니다.
의존성: aws_key_pair.project1_make_keypair, aws_security_group.project1_sg



```
#private_key.tf

resource "tls_private_key" "project1_make_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "project1_make_keypair" {
  key_name   = "project1_key"
  public_key = tls_private_key.project1_make_key.public_key_openssh
}

resource "local_file" "project1_downloads_key" {
  filename = "project1_key.pem"
  content  = tls_private_key.project1_make_key.private_key_pem
}
```
설명: RSA 개인 키를 생성하고 AWS 키페어를 관리합니다.
의존성: tls_private_key.project1_make_key



```
#security.tf
resource "aws_security_group" "project1_sg" {
  name_prefix = "project1-sg"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "project1_sg_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project1_sg.id
}

resource "aws_security_group_rule" "project1_sg_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project1_sg.id
}

resource "aws_security_group_rule" "project1_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project1_sg.id
}
```
설명: Project1을 위한 보안 그룹을 설정합니다.
의존성: var.vpc_id



```
#variables.tf(.gitignore)

variable "vpc_id" {
  type    = string
  default = "{자신의 vpc id}"
}
```
설명: 사용할 VPC ID를 정의합니다.
