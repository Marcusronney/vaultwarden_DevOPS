# Cria o Cluster EKS e adiciona Add-ons do Kubernetes/EKS (CNI, kube-proxy, CoreDNS e EBS CSI)

#nome do cluster
# Assossia o clusta a IAM ROLE criada em cluster_role.tf
# define aversão do K8S
resource "aws_eks_cluster" "this" {
  name     = var.eks_cluster_name 
  role_arn = aws_iam_role.eks_cluster.arn 
  version  = var.cluster_version 

  vpc_config { # Configura a rede e acesso ao endpoint da API do cluster.
    security_group_ids      = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id] # Define 2 SGs no Cluster e do Node
    endpoint_private_access = var.endpoint_private_access # Se o valor for True, o endpoint da API do K8s fica acessível via VPC
    endpoint_public_access  = var.endpoint_public_access # Se o valor for True, o endpoint da API do K8s fica na rede externa
    subnet_ids              = var.eks_cluster_subnet_ids # Subnet do EKS
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [ # Garante a ordem na criação e remoção
    aws_iam_role_policy_attachment.aws_eks_cluster_policy
  ]
}

# CREATE ADD ONS K8S

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = "v1.14.1-eksbuild.1"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = "v1.28.1-eksbuild.1"
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = "v1.10.1-eksbuild.2"
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"
  addon_version               = "v1.23.0-eksbuild.1"
}