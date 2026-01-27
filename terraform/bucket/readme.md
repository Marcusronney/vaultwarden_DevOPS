# Terraform

A pasta bucket/ existe para isolar o módulo de S3. Assim a gente pode aproveitar o mesmo padrão no provisionamento de vários ambiantes (Dev, Staging, Prod).

**main.tf** é o arquivo principal desse módulo, ele descreve como será deployado na AWS.
Ele irá configurar um bucket S3 privado com versionamento.

**variables.tf** define as variáveis de entrada usadas no **main.tf**. Ele tem a função de parametrizar o código e reaproveitar sem precisar ficar codando em todos os arquivos.