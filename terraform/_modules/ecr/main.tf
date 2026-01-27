resource "aws_ecr_repository" "this" {  # Definindo nome do repositório
  #  for_each             = toset(var.ecr_name)
  name                 = var.ecr_name
  image_tag_mutability = var.image_mutability # Controla se as tag podem ser sobreescritas
  encryption_configuration { # Criptografia
    encryption_type = var.encrypt_type
  }
  image_scanning_configuration { # Habilitando o scan automatico ao fazer push da imagem.
    scan_on_push = true
  }
  tags = var.tags
}