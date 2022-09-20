module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"
  name    = "app-nlb"

  load_balancer_type = "network"
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]

  target_groups = [
    {
      name_prefix      = "app-"
      backend_protocol = "TCP"
      backend_port     = 5000
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = module.ec2_instance_prod.0.id
          port      = 5000
        }
        my_other_target = {
          target_id = module.ec2_instance_prod.1.id
          port      = 5000
        }
      }
    }
  ]
  http_tcp_listeners = [
    {
      port               = 5000
      protocol           = "TCP"
      target_group_index = 0
    }
  ]
  tags = var.default_tags
}