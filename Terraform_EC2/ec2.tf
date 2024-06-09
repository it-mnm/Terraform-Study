provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "project1" {
  ami           = "ami-0e6f2b2fa0ca704d0"
  instance_type = "t2.micro"
  key_name = aws_key_pair.project1_make_keypair.key_name
  vpc_security_group_ids = [aws_security_group.project1_sg.id]
  associate_public_ip_address = true
  
  tags = {
    Name = "project1"
  }
}