variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "access_key" {}
variable "secret_key" {}
variable "key_name" {}

variable "instance_type" {
  description = "Instance Types"
  type        = string
  default     = "t2.micro"
}
variable "instance_type_large" {
  description = "Instance Types"
  type        = string
  default     = "t2.large"
}

variable "vpc_name" {
  description = "Name VPC"
  type        = string
  default     = "VPC-herbs"
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zone for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "availability_zone" {
  description = "Availability zone"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_private_subnets" {
  description = "Private Subnets for VPC"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
}

variable "ec2_instance_prod" {
  description = "Instancia de procução"
  type        = string
  default     = "WEB - PROD"
}

variable "ec2_instance_jenkins" {
  description = "Instancia de CI/CD da app"
  type        = string
  default     = "JENKINS - CI/CD"
}

variable "ec2_instance_teste" {
  description = "Server para teste da app"
  type        = string
  default     = "WEB - Teste"
}


variable "default_tags" {
  description = "Tags to Apply to all resources"
  type        = map(string)
  default = {
    onwer       = "Cleber Mota"
    Terraform   = "True"
    Environment = "dev"
  }
}