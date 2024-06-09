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
