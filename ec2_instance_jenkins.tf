module "ec2_instance_jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0.0"

  count = 1
  name  = var.ec2_instance_jenkins

  ami                         = data.aws_ami.ubuntu20_04.id
  instance_type               = var.instance_type_large
  key_name                    = var.key_name
  vpc_security_group_ids      = [module.security-group-jenkins.security_group_id]
  subnet_id                   = module.vpc.public_subnets[count.index]
  availability_zone           = var.vpc_azs[count.index]
  associate_public_ip_address = true
  user_data                   = file("user-data-jenkins.sh")

  tags = var.default_tags
}


