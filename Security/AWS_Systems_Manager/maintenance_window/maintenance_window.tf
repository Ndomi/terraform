resource "aws_ssm_maintenance_window" "maintance_Window" {
  cutoff   = 1
  duration = 4
  name     = "maintenance-window"
  schedule = "cron(0 0 ? * SUN *)"
}