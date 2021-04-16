resource "aws_cloudwatch_event_target" "sns" {
  arn       = aws_sns_topic.ec2_stopped.arn
  rule      = aws_cloudwatch_event_rule.event-rule.name
  target_id = "EC2Stopped"
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect = "Allow"
    actions = [
      "SNS:Publish"
    ]

    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
    resources = [aws_sns_topic.ec2_stopped.arn]
  }
}