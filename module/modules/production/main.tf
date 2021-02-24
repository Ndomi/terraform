module "users_group_creation" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/Users?ref=v0.0.47"
}

module "prod_computing" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/Compute?ref=v0.0.47"

}

module "ec2_monitoring" {
  source = "git::https://github.com/Ndomi/terraform.git//module/modules/Logging?ref=v0.0.47"
}