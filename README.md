# vaultwarden_DevOPS
O repositório vaultwarden tem como objetivo provisionar e executar o Vaultwarden na AWS, utilizando Terraform para infraestrutura como código e Docker para empacotamento da aplicação. O Vaultwarden é uma implementação alternativa (não oficial) do Bitwarden, escrita em Rust, amplamente usada por ser mais leve e adequada a ambientes pequenos.


## Principais Tecnologias Utilizadas

- **Terraform** – Provisionamento de infraestrutura na AWS  
- **AWS EC2** – Execução da aplicação  
- **Docker** – Containerização do Vaultwarden  
- **GitHub Actions** – Automação do deploy  
- **AWS CLI / IAM** – Autenticação e permissões

- Deploy automatizado na AWS
- Uso de Terraform para provisionamento
- Execução de aplicações containerizadas

## Visão Geral

Este repositório tem como objetivo provisionar e executar o **Vaultwarden** na **AWS**, utilizando **Terraform** como ferramenta de Infraestrutura como Código (IaC) e **Docker** para containerização da aplicação.

O projeto é voltado principalmente para **estudo, laboratório e uso pessoal**, demonstrando boas práticas básicas de automação de infraestrutura e deploy contínuo.

---

## O que é o Vaultwarden

Vaultwarden é uma implementação alternativa (não oficial) do Bitwarden, escrita em Rust, conhecida por ser:
- Mais leve
- Menos exigente em recursos
- Ideal para ambientes pequenos ou self-hosted

---

## Estrutura do Repositório

### 📁 `terraform/`
Contém os arquivos responsáveis por criar a infraestrutura na AWS. Em geral, essa infraestrutura inclui:

- Provider AWS
- Instância EC2
- Security Group com liberação de portas HTTP/HTTPS
- Variáveis e outputs
- Scripts de inicialização (user data) para instalar Docker e subir o Vaultwarden

> Os arquivos Terraform foram criados manualmente, não derivados de frameworks ou módulos oficiais.

---

### 📁 Docker / Dockerfile
Responsável por:
- Definir a imagem do Vaultwarden
- Configurar portas e volumes
- Permitir execução local ou na EC2

---

### ⚙️ GitHub Actions (`.github/workflows`)
Workflow que:
- Faz checkout do repositório
- Configura credenciais da AWS via Secrets
- Executa comandos do Terraform (`init`, `plan`, `apply`)

Isso permite deploy automatizado diretamente do GitHub para a AWS.

---

## Infraestrutura Criada (Resumo)

A infraestrutura provisionada é propositalmente simples:

- 1 instância EC2
- Security Group básico
- Docker instalado na instância
- Vaultwarden executando em container

Não há:
- Alta disponibilidade
- Load Balancer
- Auto Scaling
- Banco de dados gerenciado
- Backup automático

---

## Custos Estimados

Indicada para uso com instâncias pequenas (ex: `t3.micro`), o que resulta em:
- Custo muito baixo
- Ideal para subir, testar e destruir recursos

---
