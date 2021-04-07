module "computing" {
  source = "./computing"
}

module "maintenance_window" {
  source = "./maintenance_window"
}

module "patch_management" {
  source = "./patch_management"
}

module "parameter_store" {
  source = "./parameter_store"
}