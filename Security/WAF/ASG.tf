resource "aws_key_pair" "inspectorkey" {
  public_key = file("${path.module}/public_key/ndomi.pub")
}

resource "aws_launch_configuration" "launch_conf_1" {
  image_id = var.ec2-ami
  instance_type = var.instance_type
  name = "Server A"
  security_groups = [aws_security_group.public_SG_A.id]
  key_name = aws_key_pair.inspectorkey.key_name
  user_data = file("${path.module}/user_data.sh")
}


resource "aws_autoscaling_group" "ASG_1" {

  launch_configuration = aws_launch_configuration.launch_conf_1.id

  max_size = 3
  min_size = 1
  desired_capacity = 1
  default_cooldown = 60
  vpc_zone_identifier = [aws_subnet.public_subnet_A.id]
  target_group_arns = [aws_alb_target_group.alb_front.arn]
  health_check_type = "EC2"
  health_check_grace_period = 300


  tag {
    key = "Name"
    propagate_at_launch = true
    value = "Server A"
  }
}

resource "aws_autoscaling_policy" "ASG_Policy_up_1" {
  autoscaling_group_name = aws_autoscaling_group.ASG_1.name
  name = "Primary_policy_up"
  policy_type = "SimpleScaling"
  cooldown = 300
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1

}

resource "aws_autoscaling_policy" "ASG_Policy_down_1" {
  autoscaling_group_name = aws_autoscaling_group.ASG_1.name
  name = "Primary_policy_down"
  policy_type = "SimpleScaling"
  cooldown = 300
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1

}

####### Secondary Availability Zone #######
resource "aws_launch_configuration" "launch_config_2" {
  image_id = var.ec2-ami
  instance_type = var.instance_type
  name = "Server B"
  security_groups = [aws_security_group.public_SG_B.id]
  key_name = aws_key_pair.inspectorkey.key_name
  user_data = file("${path.module}/user_data.sh")
}

resource "aws_autoscaling_group" "ASG_2" {

  launch_configuration = aws_launch_configuration.launch_config_2.id

  max_size = 5
  min_size = 1
  desired_capacity = 1
  default_cooldown = 60
  vpc_zone_identifier = [aws_subnet.public_subnet_B.id]
  target_group_arns = [aws_alb_target_group.alb_front2.arn]
  health_check_type = "ELB"
  health_check_grace_period = 300

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "Server B"
  }
}

resource "aws_autoscaling_policy" "ASG_Policy_up_2" {
  autoscaling_group_name = aws_autoscaling_group.ASG_1.name
  name = "Secondary_policy_up"
  policy_type = "SimpleScaling"
  cooldown = 300
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1

}

resource "aws_autoscaling_policy" "ASG_Policy_down_2" {
  autoscaling_group_name = aws_autoscaling_group.ASG_1.name
  name = "Secondary_policy_down"
  policy_type = "SimpleScaling"
  cooldown = 300
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1

}

