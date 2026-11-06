resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-${var.environment}-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  # Profil IAM du Learner Lab
  iam_instance_profile {
    name = var.instance_profile_name
  }

  # Reseau des instances EC2
  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web.id]
    delete_on_termination       = true
  }

  # Exiger IMDSv2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # Script de demarrage sans mot de passe
  user_data = base64encode(var.user_data)

  # Tags des instances
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.name}-${var.environment}-web"
      Environment = var.environment
    }
  }

  tags = {
    Name        = "${var.name}-${var.environment}-lt"
    Environment = var.environment
  }
}
