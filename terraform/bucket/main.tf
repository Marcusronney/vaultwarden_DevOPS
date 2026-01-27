terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # definindo AWS
      version = "~> 5.0" # definindo versão 5.0
    }
  }
}


provider "aws" { # Definindo AWS como provedor
  region = var.aws_region #variavel de região da aws

  default_tags {
    tags = {
      owner      = "Marcus Ronney"
      managed-by = "terraform"
    }
  }
}

# Criando Buckets S3

resource "aws_s3_bucket" "bucket" { 
  bucket = var.bucket #variável para o nome do bucket
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" { # definindo regras ownership, evita problemas de objetos enviados por outras contas.
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred" # Regra deixa o bucket definir quem será o owner dos objetos.
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" { 
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership] # Garante que o ownership_controls seja aplicado

  bucket = aws_s3_bucket.bucket.id # Definindo ACL do bucket como privada.
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" { #Versionamento
  bucket = aws_s3_bucket.bucket.id 

  versioning_configuration {
    status = "Enabled" # Ativando Versionamento
  }
}
