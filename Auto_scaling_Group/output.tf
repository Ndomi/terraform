output "public_ip" {
  value = [aws_launch_configuration.launch_conf.arn]
}