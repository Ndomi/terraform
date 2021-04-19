resource "aws_sns_topic" "topic" {
  name   = "s3-event-notification-topic"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
      "Condition":{
        "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.bucket.arn}"}
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "bucket" {
  bucket = "eventnotification123000"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    events        = ["s3:ObjectCreated:*"]
    topic_arn     = aws_sns_topic.topic.arn
    filter_suffix = ".log"
  }
}