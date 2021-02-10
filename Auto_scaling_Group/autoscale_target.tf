resource "aws_autoscaling_policy" "ASG_Policy" {
  policy_type = "TargetTrackingScaling"
  name = "webserver_policy"
  autoscaling_group_name = aws_autoscaling_group.ASG.name

  target_tracking_configuration {
    target_value = 60
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}