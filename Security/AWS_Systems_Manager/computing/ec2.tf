module "networking" {
  source = "../networking"
}

resource "aws_instance" "bastion-ec2" {
  ami                  = var.ami-ID
  instance_type        = "t2.micro"
  subnet_id            = module.networking.publicSN_A
  security_groups      = [module.networking.publicSG_A]
  iam_instance_profile = aws_iam_instance_profile.profile.id
  key_name             = aws_key_pair.ssmkey.key_name
  user_data            = file("${path.module}/install-ssm.sh")

  tags = {
    Name = "Bastion EC2"
  }
}

resource "aws_instance" "private-A-ec2" {
  ami             = var.ami-ID
  instance_type   = "t2.micro"
  subnet_id       = module.networking.privateSN_A
  security_groups = [module.networking.privateSG_A]
  iam_instance_profile = aws_iam_instance_profile.s3-endpoint-profile.name
  key_name        = aws_key_pair.ssmkey.key_name
  user_data       = file("${path.module}/install-ssm.sh")


  tags = {
    Name = "Private A EC2"
  }
}

resource "aws_instance" "private-B-ec2" {
  ami             = var.ami-ID
  instance_type   = "t2.micro"
  subnet_id       = module.networking.privateSN_B
  security_groups = [module.networking.privateSG_B]
  key_name        = aws_key_pair.ssmkey.key_name
  user_data       = file("${path.module}/install-ssm.sh")

  tags = {
    Name = "Private B EC2"
  }
}