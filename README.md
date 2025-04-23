# ☁️ Infraestrutura AWS com Terraform

Este projeto provisiona uma infraestrutura na AWS utilizando **Terraform**,
com foco em **ambientes distribuídos**, **alta disponibilidade** e práticas de DevOps.
A arquitetura criada simula um ambiente real com rede pública e privada,
acesso via NAT e serviços como NGINX e Docker pré-instalados nas instâncias EC2.

---

## 📐 Arquitetura

```mermaid
graph LR
  A[VPC 10.0.0.0/24]
  A --> B[Sub-rede Pública 10.0.0.0/25]
  A --> C[Sub-rede Privada 10.0.0.128/25]
  B -->|Internet Gateway| D[Internet]
  B --> E[EC2 Web Server (NGINX + Docker)]
  C --> F[EC2 DB Server (Docker)]
  B --> G[NAT Gateway]
  C -->|Acesso à internet via NAT| G
# JK-Terraform

📦 Componentes provisionados
🔧 Rede (VPC + Subnets + Tabelas de Rota)
VPC CIDR: 10.0.0.0/24

Subnet pública: 10.0.0.0/25

Subnet privada: 10.0.0.128/25

Internet Gateway

NAT Gateway (para a subnet privada)

Tabelas de rota para internet e NAT

🔐 Segurança
2 Security Groups:

sg-web: permite HTTP (80), HTTPS (443) e SSH (22) de qualquer origem

sg-db: permite MySQL (3306) apenas da instância web

ACLs:

Pública: acesso total

Privada: acesso à porta 3306 da rede pública

🖥️ EC2 Instances
Web Server (pública):

Ubuntu

Docker

NGINX

DB Server (privada):

Ubuntu

Docker

🗂️ Estrutura do projeto

terraform/
├── main.tf
├── network/
│   ├── vpc.tf
│   ├── route_tables.tf
│   ├── nacl.tf
│   ├── variables.tf
│   └── outputs.tf
├── security_groups/
│   ├── security_groups.tf
│   ├── variables.tf
│   └── outputs.tf
├── instances/
│   ├── instances.tf
│   ├── variables.tf
│   └── outputs.tf

🚀 Como executar
Configure seu ambiente AWS com chaves válidas e permissões

Clone este repositório:
git clone <repositório>
cd terraform
terraform init
terraform plan
terraform apply

📡 Acesso
Acesse a instância web com:
ssh -i myssh-publica.pem ubuntu@<IP-público>

Acesse o site no navegador:
http://<IP-público>

✅ Outputs
IP Público da Web: terraform output web_instance_public_ip
IP Privado do DB: terraform output db_instance_private_ip