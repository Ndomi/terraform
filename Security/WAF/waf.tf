### Rate based ###
resource "aws_wafv2_web_acl" "wec_acl" {
  name = "web-acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }


  rule {
    name = "RateLimit"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        aggregate_key_type = "IP"
        limit = 500
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "RateLimit"
      sampled_requests_enabled = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name = "web-a"
    sampled_requests_enabled = false
  }

  description = "Rate based rule. 500"
}

### Region based ###
resource "aws_wafv2_web_acl" "web2_acl" {
  name = "web2_acl"
  scope = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name = "RegionBase"
    priority = 2

    action {
      allow {}
    }

    statement {
      geo_match_statement {
        country_codes = ["ZA"]
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "RegionBase"
      sampled_requests_enabled = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name = "web-b"
    sampled_requests_enabled = false
  }

  description = "Region Based Rule. Block USA and CHINA"
}

### Region based ###
resource "aws_wafv2_web_acl" "web3_acl" {
  name = "web3_acl"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {

    action {
      block {}
    }

    name = "StringBase"
    priority = 3
    statement {
      byte_match_statement {
        positional_constraint = "CONTAINS"
        search_string = "admin"

        field_to_match {
          all_query_arguments {}
        }

        text_transformation {
          priority = 3
          type = "LOWERCASE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "StringBase"
      sampled_requests_enabled = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name = "web-c"
    sampled_requests_enabled = false
  }

  description = "String Base"
}


################## Association ##################
resource "aws_wafv2_web_acl_association" "web_acl_association_alb" {
  resource_arn = aws_alb.ALB.arn
  web_acl_arn = aws_wafv2_web_acl.wec_acl.arn
}

################## Association ##################
resource "aws_wafv2_web_acl_association" "web_acl_association_alb2" {
  resource_arn = aws_alb.ALB.arn
  web_acl_arn = aws_wafv2_web_acl.web2_acl.arn
}

################## Association ##################
resource "aws_wafv2_web_acl_association" "web_acl_association_alb3" {
  resource_arn = aws_alb.ALB.arn
  web_acl_arn = aws_wafv2_web_acl.web3_acl.arn
}