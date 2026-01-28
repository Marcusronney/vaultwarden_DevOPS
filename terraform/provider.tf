
provider "aws" {
  region = var.region # ou "us-east-1" se você preferir fixo
  default_tags {
    tags = {
      owner      = "Marcus Ronney"
      managed-by = "terraform"
    }
  }
}


provider "helm" {
  kubernetes {
    host                   = module.EKS.endpoint
    cluster_ca_certificate = base64decode(module.EKS.kubeconfig_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}


provider "kubernetes" {
  host                   = module.EKS.endpoint
  cluster_ca_certificate = base64decode(module.EKS.kubeconfig_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
    command     = "aws"
  }
}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~>2.11.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~>2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.7.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "~>2.1.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-state-bucket-mronney-762012032320"
    key     = "vaultwarden/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}