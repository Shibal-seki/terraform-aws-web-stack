output "alb_security_group_id" {
  description = "ID du Security Group ALB"
  value       = aws_security_group.alb.id
}

output "web_security_group_id" {
  description = "ID du Security Group Web"
  value       = aws_security_group.web.id
}

output "alb_dns_name" {
  description = "Adresse DNS publique de l'ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ARN du Load Balancer"
  value       = aws_lb.this.arn
}

output "target_group_arn" {
  description = "ARN du Target Group"
  value       = aws_lb_target_group.this.arn
}

output "launch_template_id" {
  description = "Identifiant du Launch Template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  description = "Nom du groupe Auto Scaling"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_arn" {
  description = "ARN du groupe Auto Scaling"
  value       = aws_autoscaling_group.this.arn
}
