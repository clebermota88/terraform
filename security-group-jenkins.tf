module "security-group-jenkins" {
  source     = "terraform-aws-modules/security-group/aws"
  depends_on = [module.vpc]

  name        = "SG-Jenkins"
  description = "Security group for Jenkins"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp", "ssh-tcp"]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "Portas efemeras"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = var.default_tags
}
