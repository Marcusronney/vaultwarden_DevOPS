# Define parametros de entrada dos módulos do EKS

variable "eks_cluster_name" { # Nome do Cluster
  description = "eks-mronney"
  type        = string
}


variable "cluster_version" { # Versão do Kubernetes
  type = string
  default = "1.29"
}

variable "node_group_name" { # Nome do Worker Nodes
  description = "ng-mronney"
  type        = string
}

variable "launch_template" { # Identificador do Template que será usado nos Nodes
  type    = string
  default = "mronney-io-launch-template"
}

variable "endpoint_private_access" { # Acesso ao Endpoint da API do Kubernetes
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "endpoint_public_access" { # Habilita o Endpoint public na Rede externa
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "eks_cluster_subnet_ids" { # Subnet onde o EKS irá criar os ENIs para comunicação do Control Plane com os Nodes ( Mínimo de 2 AZs )
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "private_subnet_ids" { # Lista de Subnets Privadas
  type        = list(string)
  description = "List of private subnet IDs."
}


variable "ami_type" { # Define o tipo de AMI
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
  type        = string
  default     = "AL2_x86_64"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes. Defaults to 20."
  type        = number
  default     = 100
}

variable "eks_instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "Set of instance types associated with the EKS Node Group. Defaults to t3.medium"
}

variable "pvt_desired_size" {
  description = "Desired number of worker nodes in private subnet. Defaults to 1"
  default     = 1
  type        = number
}

variable "pvt_max_size" {
  description = "Maximum number of worker nodes in private subnet. Defaults to 1"
  default     = 1
  type        = number
}

variable "pvt_min_size" {
  description = "Minimum number of worker nodes in private subnet. Defaults to 1"
  default     = 1
  type        = number
}

# AUTOSCALING DOS NODES 

variable "pblc_desired_size" {
  description = "Desired number of worker nodes in public subnet. Defaults to 1"
  default     = 1
  type        = number
}

variable "pblc_max_size" {
  description = "Maximum number of worker nodes in public subnet. Defaults to 1"
  default     = 1
  type        = number
}

variable "pblc_min_size" {
  description = "Minimum number of worker nodes in public subnet. Defaults to 1"
  default     = 1
  type        = number
}

variable "cluster_sg_name" {
  description = "sg-eks-mronney-io"
  type        = string
}

variable "nodes_sg_name" {
  description = "sg-node-mronney-io"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID from which belogs the subnets"
  type        = string
}
