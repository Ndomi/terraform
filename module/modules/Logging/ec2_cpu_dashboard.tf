resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "EC2-CloudWatch-Dashboard"
  dashboard_body = <<EOF
  {
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-00c10897e6ca139dd", { "id": "m1" } ],
                    [ { "expression": "ANOMALY_DETECTION_BAND(m1, 2)", "label": "CPUUtilization (expected)", "id": "ad1", "color": "#95A5A6" } ]
                ],
                "region": "us-east-1"
            }
        }
    ]
}
EOF
}