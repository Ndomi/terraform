resource "aws_autoscaling_group" "ASG" {

  launch_configuration = aws_launch_configuration.launch_conf.id

  max_size = 3
  min_size = 1
  desired_capacity = 1
  availability_zones = [var.az]

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "ASG"
  }
}