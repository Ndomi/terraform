resource "aws_cloudwatch_log_group" "my_ec2_log" {
  name = "EC2_Logs"
  retention_in_days = 30
}