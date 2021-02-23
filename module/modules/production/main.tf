module "users_group_creation" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/Users?ref=v0.0.44"
  ops = "operations"
  dev = "development"
  testing = "testers"
  devops = "DevOps"
}

module "prod_computing" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/Compute?ref=v0.0.44"
  ec2_ami = "ami-047a51fa27710816e"
  key = "New_Key"
  http_port = 80
  availability_zone_B = "us-east-1b"
  availability_zone_A = "us-east-1a"
}

module "ec2_monitoring" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/Logging?ref=v0.0.44"
}