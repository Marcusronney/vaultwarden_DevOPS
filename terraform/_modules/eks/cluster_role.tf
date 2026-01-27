#https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html

resource "aws_iam_role" "eks_cluster" { #Cria uma IAM Role via variável <nome-do-cluster>-cluster, é usada pelo EKS para que o control-plane chegue até as APIs da AWS
  name = "${var.eks_cluster_name}-cluster"
  
# autoriza o serviço EKS a assumir essa role. Sem isso, o EKS não consegue usar a role e o cluster não sobe.
  assume_role_policy = <<POLICY # Define quem pode assumir a Role
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}