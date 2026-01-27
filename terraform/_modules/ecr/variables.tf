variable "ecr_name" { # Nome do repositório
  description = "The name of the ECR registry"
  type        = string
  default     = "mronney/vaultwarden"
}

variable "image_mutability" { # Define se as tasg são imutáveis ou sobreescrivíveis.
  description = "Provide image mutability"
  type        = string
  default     = "IMMUTABLE"
}


variable "encrypt_type" { # Define a criptografia como KMS por default
  description = "Provide type of encryption here"
  type        = string
  default     = "KMS"
}

variable "tags" { # Tags dos repo
  description = "The key-value maps for tagging"
  type        = map(string)
  default     = {}
}