variable "bucket_prefix" {
  default = "security"
}

variable "tags" {
  default = {
    "owner"   = "Ndomi"
    "project" = "guardduty-test"
    "client"  = "Internal"
  }
}

variable "guardduty_assets" {
  default = "guardduty"
}

variable "aws_account_id" {
  type    = number
  default = 370372383215
}

variable "group_name" {
  default = "guardduty-admin"
}

variable "users" {
  type    = list(any)
  default = ["fred", "marry"]
}