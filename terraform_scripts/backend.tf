# For init purposes, we assume that have already created S3 bucket.

terraform {
  backend "s3" {
    bucket = "lab-tfstate-bucket"
    key    = "lab-tfstate-bucket/terraform.tfstate"
    region = "us-east-1"
  }
}