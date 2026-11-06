# Auto Scaling Group NovaSphere
resource "aws_autoscaling_group" "this" {
  name_prefix = "${var.name}-${var.environment}-asg-"

  # Nombre d'instances
  min_size         = 2
  max_size         = 4
  desired_capacity = var.desired_capacity

  # Repartition sur les subnets publics
  vpc_zone_identifier = var.public_subnet_ids

  # Liaison avec le Target Group
  target_group_arns = [
    aws_lb_target_group.this.arn
  ]

  # Verification de la sante des instances
  health_check_type         = "ELB"
  health_check_grace_period = 300

  # Modele de lancement EC2
  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  # Tags des instances
  tag {
    key                 = "Name"
    value               = "${var.name}-${var.environment}-web"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}
