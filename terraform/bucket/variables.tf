variable "aws_region" { # Variável que define a região da AWS, ela é chama no main.tf em var.aws_region
  type    = string
  default = "us-east-1"
}

variable "bucket" { # Variável dos Buckets. 
  type        = string
  description = "S3_projeto_DEVOPS31312"
  default     = "terraform-state-bucket-mronney-762012032320"
}

