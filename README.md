# ☁️ Static Website Hosting on Google Cloud Platform with Terraform

Este repositório contém o código de **Infraestrutura como Código (IaC)** escrito em **Terraform** para provisionar e implantar um site estático na **Google Cloud Platform (GCP)**, utilizando boas práticas de segurança, armazenamento em nuvem e distribuição de conteúdo via CDN.

---

## 📐 Arquitetura da Solução

O projeto cria a seguinte estrutura na GCP:

```text
[Usuário] 
    │
    ▼ (HTTP / Porta 80)
[External Load Balancer] (IP Estático Reservado)
    │
    ▼
[Cloud CDN + Backend Bucket] (Cache global para baixa latência)
    │
    ▼
[Google Cloud Storage (GCS)] (Bucket privado armazenando o index.html)

Principais Componentes Provisionados:

    Google Cloud Storage (GCS): Armazenamento de arquivos estáticos (index.html).

    Cloud Storage Object Access Control: Permissões granulares de acesso público aos arquivos do site.

    Global Static IP Address: Reserva de um endereço IP público estático para o Load Balancer.

    Backend Bucket + Cloud CDN: Habilitação de cache distribuído globalmente para melhorar a performance de entrega do site.

    HTTP Target Proxy & URL Map: Regras de roteamento de tráfego do Load Balancer.

    Global Forwarding Rule: Entrada de tráfego na rede do GCP direcionada para a porta 80.

🛠️ Tecnologias Utilizadas

    Terraform: Gerenciamento e provisionamento de infraestrutura declarativa.

    Google Cloud Platform (GCP): Provedor de nuvem para hospedar os recursos.

    HTML5: Código fonte do site estático.

    Git & GitHub Actions: Controle de versão e automação de CI/CD.

📂 Estrutura do Repositório
Plaintext

projeto_1/
├── .gitignore              # Arquivos e pastas ignorados pelo Git (.terraform, .tfstate, etc)
├── README.md               # Documentação do projeto
├── infra/                  # Código do Terraform
│   ├── main.tf             # Recurso e definição de infraestrutura GCP
│   ├── provider.tf         # Configuração do provedor do Google
│   ├── variables.tf        # Variáveis de entrada
│   └── terraform.tfvars    # Valores das variáveis do projeto
└── website/                # Código fonte da aplicação web
    └── index.html          # Página principal do site

🚀 Como Executar o Projeto Localmente
Pré-requisitos

    Ter o Terraform CLI instalado na sua máquina.

    Ter o Google Cloud SDK (gcloud CLI) configurado e autenticado na sua conta GCP.

    Ter um projeto ativo na GCP com cobrança habilitada.

Passo a Passo

    Clone o repositório:
    Bash

    git clone [https://github.com/YuriCS02/project_1_terraform_gcloud.git](https://github.com/YuriCS02/project_1_terraform_gcloud.git)
    cd project_1_terraform_gcloud/infra

    Inicialize os provedores do Terraform:
    Bash

    terraform init

    Verifique o plano de execução:
    Bash

    terraform plan

    Aplique as mudanças na nuvem:
    Bash

    terraform apply

    (Digite yes para confirmar a criação dos recursos).

    Acesse o site:
    Após a conclusão do apply, acesse o IP Público gerado pelo Load Balancer no seu navegador para visualizar o site no ar.

🛠️ Destruindo a Infraestrutura

Para evitar cobranças indesejadas após os testes, execute o comando para remover todos os recursos criados:
Bash

terraform destroy

🙏 Créditos e Agradecimentos

Este projeto foi desenvolvido por Yuri Calil,com fins de estudo e prática de IaC (Infrastructure as Code) e Google Cloud Platform.

O projeto foi baseado e inspirado no tutorial em vídeo do canal de Rishab Kumar (link: https://www.youtube.com/@rishabincloud) , que cria conteúdos sobre DevOps, Terraform e Cloud Engineering.

