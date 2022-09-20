module "ec2_instance_prod" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0.0"

  count = 2
  name  = "WEB - PROD - ${count.index}"

  ami                         = data.aws_ami.ubuntu20_04.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [module.security-group-web.security_group_id]
  subnet_id                   = module.vpc.public_subnets[count.index]
  availability_zone           = var.vpc_azs[count.index]
  associate_public_ip_address = true
  user_data                   = file("user-data-prod.sh")

  tags = var.default_tags
}

resource "aws_eip" "instanceProd0" {
  depends_on = [module.ec2_instance_prod]
  vpc        = true
  instance   = module.ec2_instance_prod.0.id
  tags = {
    Name = "elastic_ip_prod"
  }
}
resource "aws_eip" "instanceProd1" {
  depends_on = [module.ec2_instance_prod]
  vpc        = true
  instance   = module.ec2_instance_prod.1.id
  tags = {
    Name = "elastic_ip_prod"
  }
}



