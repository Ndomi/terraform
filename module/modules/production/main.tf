/*
module "users_group_creation" {
  source = "../Users"
}
*/

module "users_group_creation" {
  source = "git::https://github.com/Ndomi/terraform.git?ref=v0.0.1"
}

module "prod_computing" {
  source = "../Compute"
}

module "ec2_monitoring" {
  source = "../Logging"
}

### Place holder ###