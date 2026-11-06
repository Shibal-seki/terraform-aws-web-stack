variable "name" {
  description = "Nom du projet"
  type        = string
}

variable "environment" {
  description = "Environnement DEV ou PROD"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "L'environnement doit etre dev ou prod."
  }
}

variable "vpc_id" {
  description = "Identifiant du VPC AWS"
  type        = string
}

variable "public_subnet_ids" {
  description = "Identifiants des subnets publics"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "Au moins deux subnets sont necessaires."
  }
}

variable "ami_id" {
  description = "AMI utilisee par les instances EC2"
  type        = string
}

variable "instance_type" {
  description = "Type des instances EC2"
  type        = string
}

variable "instance_profile_name" {
  description = "Nom du profil IAM existant"
  type        = string
}

variable "user_data" {
  description = "Script de demarrage sans secret"
  type        = string
}

variable "desired_capacity" {
  description = "Nombre d'instances EC2 souhaite"
  type        = number
  default     = 2

  validation {
    condition     = var.desired_capacity >= 2 && var.desired_capacity <= 4
    error_message = "La capacite doit etre comprise entre 2 et 4."
  }
}
