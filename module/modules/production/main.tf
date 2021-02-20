module "users_group_creation" {
  source = "../Users"
}

module "prod_computing" {
  source = "../Compute"
}

module "ec2_monitoring" {
  source = "../Logging"
}