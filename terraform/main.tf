data "aws_availability_zones" "available" {
  state = "available"
}


module "VPC" {
  source = "./_modules/vpc-modules/vpc"

  name = "mronney-vaultwarden"

  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  enable_dns_hostnames = true
  tags                 = var.tags
}

module "SUBNETS" {
  source = "./_modules/vpc-modules/subnets"

  name = "mronney-vaultwarden"

  single_nat_gateway = true
  azs                = data.aws_availability_zones.available.names
  enable_nat_gateway = true

  vpc_id = module.VPC.vpc_id
  igw_id = module.VPC.igw_id

  private_subnets = var.cidrs["private"]
  public_subnets  = var.cidrs["public"]


  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
    "kubernetes.io/role/internal-elb"               = "1",
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
    "kubernetes.io/role/elb"                        = "1",
  }
  tags = var.tags
}


## EKS Cluster
module "EKS" {
  source = "./_modules/eks"
  # Cluster
  vpc_id                 = module.VPC.vpc_id
  cluster_sg_name        = "${var.eks_cluster_name}-cluster-sg-mronney"
  nodes_sg_name          = "${var.eks_cluster_name}-node-sg-mronney"
  eks_cluster_name       = var.eks_cluster_name
  eks_cluster_subnet_ids = module.SUBNETS.private_subnets
  cluster_version        = var.cluster_version

  # Node group configuration (including autoscaling configurations)
  pvt_desired_size        = 2
  pvt_max_size            = 3
  pvt_min_size            = 2
  endpoint_private_access = true
  node_group_name         = "${var.eks_cluster_name}-node-group"
  private_subnet_ids      = module.SUBNETS.private_subnets

}

module "ECR" {
  source           = "./_modules/ecr"
  ecr_name         = var.ecr_name
  tags             = var.tags
  image_mutability = var.image_mutability
}


