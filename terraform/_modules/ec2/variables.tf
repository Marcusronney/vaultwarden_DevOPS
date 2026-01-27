variable "ami" { # sistema da instância
  type = string
}

variable "instance_type" { # tipo da instância
  type = string
}

variable "key_name" { # chave do Key Pair, se nada for definido, irá usar mronney
  type    = string
  default = "mronney"
}

variable "subnet_id" { # Subnet, quando sem nada, é definido como Any
}

variable "tags" { # Tags EC2
  description = "A mapping of tags to assign to ec2"
  type        = map(string)
  default     = {}
}

variable "vpc_security_group_ids" {} # Variável de grupo de segurança

variable "associate_public_ip_address" { # Variável de IP, definindo do tipo booleano
  type = bool
}
