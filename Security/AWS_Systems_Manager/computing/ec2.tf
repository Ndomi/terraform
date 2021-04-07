module "networking" {
  source = "../networking"
}

resource "aws_instance" "ec2" {
  ami = var.ami-ID
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssmkey.key_name
  subnet_id = module.networking.publicSN_A
  security_groups = [module.networking.publicSG_A]
  iam_instance_profile = aws_iam_instance_profile.profile.id
  user_data = file("${path.module}/install-ssm.sh")

  tags = {
    Name = "EC2 Instance"
  }
}