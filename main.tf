# Security Group du Load Balancer
resource "aws_security_group" "alb" {
  name_prefix = "${var.name}-${var.environment}-alb-"
  description = "Security Group du Load Balancer"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.name}-${var.environment}-alb"
    Environment = var.environment
  }
}

# Security Group des instances EC2
resource "aws_security_group" "web" {
  name_prefix = "${var.name}-${var.environment}-web-"
  description = "Security Group des instances Web"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.name}-${var.environment}-web"
    Environment = var.environment
  }
}

# Internet vers ALB : HTTP 80
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# ALB vers instances EC2 : HTTP 80 uniquement
resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id            = aws_security_group.web.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

# Sortie ALB vers les instances Web
resource "aws_vpc_security_group_egress_rule" "alb_to_web" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.web.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

# Sortie Web HTTP pour installation des paquets
resource "aws_vpc_security_group_egress_rule" "web_http_out" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Sortie Web HTTPS pour AWS SSM et mises a jour
resource "aws_vpc_security_group_egress_rule" "web_https_out" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
