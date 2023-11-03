variable "inbound_port_production_ec2" {
  type        = list(any)
  default     = [22, 80]
  description = "inbound port allow on production instance"
}

variable "db_name" {
  type    = string
  default = "wordpressdb"
}

variable "db_user" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  default = "Wordpress-AWS2Tier"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-0fc5d935ebf8bc3bc"
}

variable "key_name" {
  type    = string
  default = "wordpressKey"
}

variable "availability_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "list of all cidr for subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "target_application_port" {
  type    = string
  default = "80"
}

variable "regional_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "backup_volume_size" {
  default = 50
}

variable "cold_storage_move" {
  default = 14
}

variable "cold_storage_retentioin" {
  default = 365
}

variable "rds_retention_period" {
  default = 7
}

variable "rds_backup_window" {
  type    = string
  default = "00:00-02:00"
}

variable "monitoring_metrics" {
  type    = string
  default = "CPUUtilization,NetworkOut,NetworkIn"
}

variable "monitoring_metrics_namespace" {
  type    = string
  default = "AWS/EC2"
}

variable "monitoring_period" {
  type    = string
  default = "120"
}

variable "monitoring_threshold" {
  type    = string
  default = "80"
}

variable "monitoring_eval_periods" {
  type    = string
  default = "2"
}

variable "monitoring_comparisson_operator" {
  type    = string
  default = "GreaterThanOrEqualToThreshold"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
