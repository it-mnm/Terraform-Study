# Terraform_EC2


* ### [ec2.tf](https://github.com/it-mnm/Terraform-Study/blob/main/Terraform_EC2/ec2.tf)
  * Project1을 위한 EC2 인스턴스를 설정합니다. 
  * 의존성: aws_key_pair.project1_make_keypair, aws_security_group.project1_sg
---------

* ### [private_key.tf](https://github.com/it-mnm/Terraform-Study/blob/main/Terraform_EC2/private_key.tf)

  * RSA 개인 키를 생성하고 AWS 키페어를 관리합니다.  
  * 의존성: tls_private_key.project1_make_key
--------


* ### [security.tf](https://github.com/it-mnm/Terraform-Study/blob/main/Terraform_EC2/security.tf)

  * Project1을 위한 보안 그룹을 설정합니다.  
  * 의존성: var.vpc_id
-----


* ### variables.tf(.gitignore)
  * 사용할 VPC ID를 정의합니다.

