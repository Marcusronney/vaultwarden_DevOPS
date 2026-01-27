resource "aws_instance" "this" { # Variáveis para instalação de instâncias EC2
  ami                         = var.ami # imagem do S.O
  instance_type               = var.instance_type #tipo de instância
  key_name                    = var.key_name # nome das chaves
  subnet_id                   = var.subnet_id # Definindo as Subnet
  vpc_security_group_ids      = var.vpc_security_group_ids # Grupos de Segurança
  associate_public_ip_address = var.associate_public_ip_address # Associando IP das Instâncias

  tags = {}

  root_block_device { # Disco (Volumes)
    volume_size = 50 #tamanho
    volume_type = "gp2" #tipo do volume
    encrypted   = true #criptografia
  }

}
