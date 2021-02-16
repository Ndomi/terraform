module "networking" {
  source = "../networking"
}

resource "aws_instance" "Jumpbox" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [module.networking.publicSG]
  subnet_id = module.networking.publicSN
  key_name = var.key

  tags = {
    Name = "Public EC2"
  }

  depends_on = [module.networking.vpc_id, module.networking.publicSN]
}

resource "aws_instance" "app_server" {
  ami = var.ec2_ami
  instance_type =var.ec2_instance_type
  vpc_security_group_ids = [module.networking.privateSG]
  subnet_id = module.networking.privateSN
  key_name = var.key

  tags = {
    Name = "Private EC2"
  }

  depends_on = [module.networking.vpc_id, module.networking.privateSN]
}