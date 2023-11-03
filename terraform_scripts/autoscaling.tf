# This module will initialize autoscaling parameters for AWS EC2 instances.

resource "aws_launch_configuration" "wordpress_autoscale" {
  image_id        = var.ami
  instance_type   = "t2.micro"
  user_data       = file("install_script.sh")
  security_groups = [aws_security_group.production-instance-sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wordpress_autoscale" {
  min_size             = 2
  max_size             = 10
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.wordpress_autoscale.name
  vpc_zone_identifier  = [aws_subnet.ec2_1_public_subnet.id, aws_subnet.ec2_2_public_subnet.id]
}
