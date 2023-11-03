# This module will create and activate monitoring resource for the Wordpress Application.
# By design, it will use the AWS CloudWAtch service for this purpose.
# Also, it will monitor the all instances in AWS EC2 for CPU usage and Networking activity. 

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "cpu-utilization"
  comparison_operator = var.monitoring_comparisson_operator
  evaluation_periods  = var.monitoring_eval_periods

  metric_name = var.monitoring_metrics
  namespace   = var.monitoring_metrics_namespace


  period            = var.monitoring_period
  statistic         = "Average"
  threshold         = var.monitoring_threshold
  alarm_description = "This metric checks cpu utilization"
  alarm_actions     = [aws_sns_topic.cpu_alarm.arn]
}

resource "aws_sns_topic" "cpu_alarm" {
  name = "cpu-utilization-alarm"
}
