output "ec2_instance_public_ips" {
  description = "Public ip addresses of EC2 instances"
  value       = module.ec2_instance_jenkins.*.public_ip
}

output "ec2_instance_teste_public_ips" {
  description = "Public ip addresses of EC2 instances"
  value       = module.ec2_instance_teste.*.public_ip
}

output "ec2_instance_prod_public_ips" {
  description = "Public ip addresses of EC2 instances"
  value       = module.ec2_instance_prod.*.public_ip
}

output "nlb_lb_dns_name" {
  description = "Address"
  value       = module.nlb.lb_dns_name
}