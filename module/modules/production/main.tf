/*module "prod_vpc" {
  source = "../networking"
}*/

module "users_group_creation" {
  source = "../Users"
}

module "prod_computing" {
  source = "../Compute"
}