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

module "main_account_events" {
  source = "./CloudWatch_Events"
  create = true
}

module "cloudtrail" {
  source = "./cloudTrail"
}

module "s3_evewnt_notification" {
  source = "./s3_event_notification"
}