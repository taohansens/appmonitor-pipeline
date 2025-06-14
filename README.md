![CI Pipeline](https://img.shields.io/github/actions/workflow/status/taohansens/appmonitor-pipeline/ci.yml?branch=main)

## INFNET AT - Pipelines de CI/CD e DevOps [25E2_3]

# AppMonitor Pipeline

Sistema de monitoração de aplicações web com pipelines automatizados de CI/CD.

## 📋 Sobre o Projeto

O AppMonitor é um projeto que simula a monitoração de aplicações web através de scripts automatizados.

## 🚀 Começando

### Pré-requisitos

- Bash (Linux/macOS) ou Git Bash (Windows)
- Acesso ao repositório GitHub

### Execução

```bash
# Tornar o script executável (Linux/macOS)
chmod +x status-check.sh

# Executar o script
./status-check.sh
```

## Etapas do Pipeline

### 1. ci/Validação
- Verifica a sintaxe do script `status-check.sh`.
- Gera erro e logs claros caso haja problemas de sintaxe.

### 2. ci/Testes
- Simula a execução de testes automatizados.
- Exibe logs de execução.

### 3. ci/Empacotamento
- Gera o artefato `report.zip` contendo arquivos importantes.
- Faz upload do artefato para consulta posterior.

### 4. ci/Resumo Automatizado
- Gera um summary ao final do pipeline, incluindo:
  - Ambiente de execução (SO, branch)
  - Status de cada etapa
  - Link direto para download do artefato gerado

### 5. Deploy com Aprovação Manual
- o workflow `deploy.yml` aciona o deploy para o ambiente de produção somente após aprovação manual.
- Utiliza variável de ambiente segura (`PROD_DOMAIN`) configurada no ambiente `production` do GitHub.

### 6. Diagnóstico Automatizado de Falhas
- O workflow `diagnostic.yml` verifica se variáveis obrigatórias (`APP_ENV`, `API_KEY`) estão definidas.
- Gera logs, mensagens de erro e um summary com sugestões de correção caso falte alguma variável.

---

## Configurações Necessárias

### Ambientes e Variáveis

- **Ambiente `production`:**
  - Crie em: `Settings > Environments > New environment`
  - Nome: `production`
  - Variável: `PROD_DOMAIN=appmonitor.com`
  - Adicionar revisores para que haja aprovação manual.

  - **Ambiente `dev`:**
  - Crie em: `Settings > Environments > New environment`
  - Nome: `dev`
  - Variável: `APP_ENV=dev`
  - Secret: `API_KEY=random`

- **Obrigatórios para diagnóstico: (ambiente: dev)**
  - `APP_ENV` (Variable)
  - `API_KEY` (Secret)
---

## Git e Entrega Contínua

O Git é fundamental na entrega contínua porque organiza todo o desenvolvimento de forma clara e confiável: cada alteração no código fica registrada com informações sobre autor, data e propósito, o que traz segurança para a equipe saber quem fez o quê e evita dúvidas na hora de conferir o histórico do projeto.
Além disso, permite que cada desenvolvedor trabalhe em sua própria cópia do repositório sem bloqueios, facilitando o paralelismo e acelerando o ritmo de trabalho.

Essa estrutura de versionamento também abre caminho para automações de CI/CD, já que qualquer mudança enviada ao repositório aciona pipelines que compilam, testam e implantam o software automaticamente. Se algum erro surgir, podemos reverter para uma versão anterior rapidamente, sem perda de dados ou tempo, garantindo entregas ágeis e de qualidade constante.

### Importância de Branches

As branches são importantes para manter o desenvolvimento organizado e seguro, elas permitem isolar cada nova funcionalidade do restante do código: dessa forma, ao criar uma branch para uma feature específica, podemos implementar e testar alterações sem o risco de quebrar a versão estável do projeto.
Esse isolamento facilita a colaboração, já que cada membro da equipe pode trabalhar em paralelo em suas próprias branches, reduzindo conflitos e acelerando o progresso.

Também suportam fluxos de trabalho estruturados, ao definirmos etapas claras para revisão e implantação: antes de mesclar uma branch ao tronco principal, é comum ser aberto um pull request para que colegas façam code review, garantindo qualidade e consistência.
Com essas estratégias de deploy, podemos integrar novas features de forma controlada e até automatizar pipelines de CI/CD para ambientes de teste e produção, tornando a entrega mais confiável e previsível.

### Importância das Tags

As tags servem para aplicar versionamento semântico de forma clara e organizada, pois permitem marcar pontos específicos no histórico — como v0.1.0, como orientado no AT — facilitando a identificação de versões e a comunicação sobre as mudanças introduzidas. Ao definir essas marcações, garantimos que exista um registro imutável de releases estáveis, o que confere confiança ao distribuir pacotes ou binários, já que saberemos exatamente em qual commit aquela versão foi gerada.

Adicionalmente elas também servem como gatilhos para automação de deploy, pois pipelines de CI/CD podem ser configurados para disparar apenas quando uma nova tag de release for criada, assegurando que somente versões aprovadas sejam levadas a ambientes de produção. Em situações de emergência ou bugs críticos, inclusive, podemos usar essas tags para realizar rollback rápido a um estado conhecido e funcional do código, minimizando impactos no usuário final; por fim, associar cada tag a um changelog ou release notes ajuda a documentação do projeto a ficar sempre atualizada e acessível.

## Diferenças entre env, vars e secrets no GitHub Actions

- **env**: Variáveis de ambiente definidas diretamente no workflow, job ou step. São úteis para valores temporários ou específicos daquele workflow/job.
- **vars**: Variáveis de repositório, configuradas nas configurações do GitHub. São acessíveis em todos os workflows do repositório via `${{ vars.NOME }}`. Úteis para valores compartilhados e não sensíveis.
- **secrets**: Segredos do repositório, também configurados nas configurações do GitHub. São usados para armazenar informações sensíveis (como tokens e senhas) e acessados via `${{ secrets.NOME }}`. Não são exibidos nos logs.

## Monitoramento e Depuração

Conforme realizado na Etapa 4 do AT, o workflow gera logs detalhados e um summary ao final de cada execução.  
- **Logs de debug** ajudam a identificar rapidamente falhas e entender o que ocorreu em cada etapa.
- **Summaries** fornecem um resumo do ambiente, status dos jobs e link direto para o artefato gerado, facilitando o acompanhamento e auditoria do pipeline.
