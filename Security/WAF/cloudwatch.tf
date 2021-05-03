############# Primary ################

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-up-1" {
  alarm_name          = "example-cpu-alarm-up-1"
  alarm_description   = "example-cpu-alarm-up-1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.ASG_1.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.ASG_Policy_up_1.arn]
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown-down-1" {
  alarm_name          = "example-cpu-alarm-scaledown-down-1"
  alarm_description   = "example-cpu-alarm-scaledown-down-1"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.ASG_1.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.ASG_Policy_down_1.arn]
}

############# Secondary ################

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-up-2" {
  alarm_name          = "example-cpu-alarm-up-2"
  alarm_description   = "example-cpu-alarm-up-2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.ASG_2.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.ASG_Policy_up_2.arn]
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown-down-2" {
  alarm_name          = "example-cpu-alarm-scaledown-down-2"
  alarm_description   = "example-cpu-alarm-scaledown-down-2"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.ASG_2.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.ASG_Policy_down_2.arn]
}