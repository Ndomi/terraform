resource "aws_cloudwatch_event_rule" "event-rule" {
  name        = "capture-stopped-instances"
  description = "Capture a Stopped Instance"

  event_pattern = <<EOF
  {
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ],
  "detail":{
    "state": [
      "launched",
      "terminated",
      "failed",
      "stopped"
    ]
  }
}
EOF
}