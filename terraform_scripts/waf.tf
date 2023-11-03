# This module will create Web Application Firewall (WAF) in AWS
# The purpose of it, is to protect the infrastructure and limit the WEB requests, coming from Internet.

resource "aws_wafv2_web_acl" "wordpress_webacl" {
  name  = "wordpress_webacl"
  scope = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "rateLimitRule"
    priority = 0

    action {
      count {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-metric-name"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}