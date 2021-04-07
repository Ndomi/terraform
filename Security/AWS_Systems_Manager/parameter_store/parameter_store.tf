resource "aws_ssm_parameter" "param_store" {
  name = "param_store"
  type = "SecureString"
  value = var.db_parameter
  description = "The Parameter Store"

  tags = {
    Name = "Testing"
  }
}