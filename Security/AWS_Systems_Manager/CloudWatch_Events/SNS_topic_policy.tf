resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.ec2_stopped.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}