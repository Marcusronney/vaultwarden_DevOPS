
module "SG_EC2" {
  source                             = "./_modules/security-group"
  create                             = true
  vpc_id                             = module.VPC.vpc_id
  name                               = "sg EC2 instances"
  description                        = "Security group created to communicate EC2"
  number_of_ingress_with_cidr_blocks = 1
  ingress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Ingress Traffic"
    }
  ]
  number_of_egress_with_cidr_blocks = 1

  egress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Egress Traffic"
    }
  ]
  tags = var.tags
}
