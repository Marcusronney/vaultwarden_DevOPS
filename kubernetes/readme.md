# Vaultwarden no Kubernetes

Este diretório contém os **manifests Kubernetes** responsáveis por implantar o **Vaultwarden** em um cluster Kubernetes, utilizando **Traefik** como Ingress Controller e **cert-manager** para emissão automática de certificados TLS via **Let’s Encrypt**.

---

## Arquitetura

O Vaultwarden é executado como um **container** dentro de um **Pod**, gerenciado por um `Deployment`.  
Os binários do Vaultwarden **não são instalados manualmente nos nós** — eles já vêm empacotados na imagem Docker `vaultwarden/server`, que é baixada automaticamente pelo Kubernetes a partir de um registry público quando o Pod é criado.

Componentes principais:

- Vaultwarden (container Docker)
- PersistentVolumeClaim (persistência de dados)
- Service (exposição interna)
- Traefik IngressRoute (exposição externa HTTPS)
- cert-manager + Let’s Encrypt (TLS automático)

---

## Fluxo de Funcionamento

1. O Kubernetes cria o Pod do Vaultwarden usando a imagem Docker.
2. O container é iniciado com limites de CPU e memória definidos.
3. Um PVC é anexado ao Pod para persistir dados.
4. Um Service do tipo ClusterIP expõe o Pod internamente.
5. O Traefik roteia requisições externas HTTPS para o Service.
6. O cert-manager solicita e renova certificados TLS via Let’s Encrypt.

---

## Manifests e Responsabilidades

### 1. ClusterIssuer (`ClusterIssuer`)
Define o **Let’s Encrypt** como emissor de certificados TLS em nível de cluster, usando o desafio ACME HTTP-01 resolvido pelo Traefik.

**Responsável por:**
- Integração com a API do Let’s Encrypt
- Emissão e renovação automática de certificados

---

### 2. Certificate (`Certificate`)
Solicita um certificado TLS para o domínio configurado e armazena o certificado/ chave privada em um Secret Kubernetes.

**Responsável por:**
- Criar o Secret TLS usado pelo Ingress
- Associar domínio ao emissor configurado

---

### 3. Deployment (`Deployment`)
Define como o Vaultwarden é executado no cluster.

Principais características:
- 1 réplica (modo simples/laboratório)
- Imagem: `vaultwarden/server:latest`
- Limites de CPU e memória
- Porta 80 exposta no container
- Volume persistente montado para dados

**Observação:** os dados do Vaultwarden devem ser gravados no volume persistente para não serem perdidos em reinícios do Pod.

---

### 4. PersistentVolumeClaim (`PersistentVolumeClaim`)
Solicita armazenamento persistente para os dados do Vaultwarden.

Configuração:
- Acesso `ReadWriteOnce`
- 10Gi de armazenamento
- Usa a StorageClass padrão do cluster (ex.: EBS CSI no EKS)

---

### 5. Service (`Service`)
Cria um ponto de acesso interno para o Vaultwarden dentro do cluster.

Configuração:
- Tipo: `ClusterIP`
- Porta 80
- Seleção via label `app: vaultwarden`

Esse Service é consumido pelo Ingress/IngressRoute.

---

### 6. IngressRoute (`IngressRoute`)
Configura a exposição externa do Vaultwarden via **Traefik**.

Funcionalidades:
- Acesso HTTPS (`websecure`)
- Roteamento por host (`example.com`)
- Integração com cert-manager para TLS
- Aplicação de middleware (ex.: basic-auth)

---

## Persistência de Dados

- Os dados do Vaultwarden não ficam no container.
- O armazenamento é feito via **PersistentVolumeClaim**.
- Em EKS, o volume normalmente é provisionado como um **EBS**.
- Isso garante que dados sobrevivam a reinícios e recriações de Pods.

---

## Segurança

- Comunicação externa protegida por **TLS (HTTPS)**.
- Certificados emitidos automaticamente pelo Let’s Encrypt.
- Middleware de autenticação básica no Traefik (opcional).
- Limites de recursos configurados para o container.


---

## Como Aplicar

```bash
kubectl apply -f kubernetes/
