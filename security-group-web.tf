module "security-group-web" {
  source     = "terraform-aws-modules/security-group/aws"
  version    = "4.9.0"
  depends_on = [module.vpc, module.security-group-jenkins]

  name        = "SG-Webserver"
  description = "SG webserver e acesso SSH"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      description = "Open port 5000"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  computed_ingress_with_source_security_group_id = [
    {
      description              = "Allow communicate with Jenkins"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      source_security_group_id = module.security-group-jenkins.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

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