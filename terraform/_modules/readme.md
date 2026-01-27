# EC2

Módulos que criam instâncias EC2 passando por variáveis. O módulo EC2 cria uma instância virtual na AWS usando uma AMI e tipo de instância definidos por variáveis.

Ele permite escolher a subnet e os security groups, controlando onde a instância roda e quais acessos de rede são permitidos.

O acesso via SSH é configurado por um Key Pair, com valor padrão definido no módulo.

É possível decidir se a instância terá ou não um IP público, tornando-a pública ou privada.

A instância é criada com um disco root de 50 GB, criptografado, usando EBS SSD.

Todas as configurações são parametrizadas para reutilização do módulo em diferentes ambientes.

# ECR - Elastic Container Registry

Registry Privado para armazenar imagens Docker.

Esse módulo cria um repositório ECR com scan de vulnerabilidades no push, criptografia em repouso e política de tag imutável por padrão, além de permitir tags AWS via variável.

# EKS 

_modules/ec2/main.tf cria uma instância EC2 parametrizada (AMI, tipo, subnet, SG e IP público), com volume root criptografado de 50 GB.

_modules/ec2/variables.tf define as variáveis obrigatórias e opcionais para criação da EC2, como AMI, tipo de instância, rede, chave SSH e IP público.

_modules/ecr/main.tf cria um repositório ECR privado com criptografia, scan de vulnerabilidades no push e política de tags imutáveis por padrão.

_modules/ecr/variables.tf define o nome do repositório, política de mutabilidade, tipo de criptografia e tags do ECR.

eks/cluster_role.tf cria a IAM Role do control plane do EKS e anexa a policy necessária para o cluster operar e gerenciar recursos AWS.

eks/cluster_sg.tf cria o Security Group do cluster EKS e libera comunicação segura entre o API Server e os worker nodes.

eks/cluster.tf cria o cluster EKS, configura acesso ao endpoint (público/privado), subnets e instala os add-ons essenciais do Kubernetes (CNI, kube-proxy, CoreDNS e EBS CSI).

eks/variables.tf define todas as variáveis do EKS, incluindo nome e versão do cluster, rede, configuração de nodes, tipos de instância e parâmetros de autoscaling.