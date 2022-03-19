This template helps you write a design document in the form envisioned by  .

Current Status:  (see recommended values)

Context & scope

This section describes the forces acting on the system that readers must understand. This may be done across multiple paragraphs, but should focus on the problem not the solution.

Antes de começarmos a falar da motivação de implantação do Kubecost, acho importante trazer aqui o contexto de como está hoje a infraestrutura da loggi. 

Neste momento a Loggi faz uso de dois cloud providers: AWS e Azure. Na Azure dispomos de um cluster kubernetes, no qual encontra-se em execução a aplicação, core da empresa,  o loggiweb. Temos tambeḿ os bancos de dados,  Machine Learnings, algumas ferramentas como Rundeck provisionados neste provider.

Já na AWS temos um segundo cluster Kubernetes em que estão deployadas as aplicações adjacentes ao loggiweb - que fazem parte do ecossistema, porém não possuem dependencia direta. Neste provider temos também provisionados os Redshifts, Rekognition, SageMaker, Lambda, S3, etc …

Goals

Goals of the system, within that context. Typically written as bullets, they talk about the parts of the problem that will be solved or significantly addressed by the change you are proposing.

Fornecer visibilidade de custo  individualmente por serviços , que esteja sendo executado no Kubernetes; 

Non-goals

Things that should be reasonably expected to be goals of the system within the chosen scope and context, but you have decided to not include as goals, as well as the reason they have been excluded.

Fornecer visibilidade de custo de serviços externos ao clusters Kubernetes;

Overview

Now you start talking about the solution. This helps readers gain an understanding of the overall approach, which will make it much easier to evaluate how the details relate to the design.

Em ambos os providers temos meios de verificar o custo que cada serviços despende, no entanto os relatório de billing necessitam que os recursos sejam identificados através de Tags. e esse trabalho é custoso, pois necessita que sejam verificados recurso por recurso - pois é preciso identificar, por exemplo, se a VPC verificada faz parte do cluster de kubernetes, ou do cluster de cluster de Redshift -  e identificado quem faz uso, tornando-se também bastante complexo, pois há recusos que são compartilhados por mais de um serviço, além de ser excessivamente complexa incumbência de efetuar o rateio de custos de trafego de dados para cada um dos serviços. 

multi-cloud

kubecost

O Kubecost fornece visibilidade de custos em tempo real.

Após esse overview sobre a atual infraestrutura fica mais fácil entender / explicar a necessidade de haver uma aplicação como o kubecost. 

O Kubecost ajuda a monitorar e gerenciar custos e capacidade em ambientes Kubernetes. Integrando a infraestrutura para ajudar sua equipe a rastrear, gerenciar e reduzir gastos.

Detailed Design

This section explains the design, it's trade offs and consequences as appropriate. This should thus be as short as possible and as long as necessary. Key design elements to think about:

- the data model and the backend where it resides- public APIs, gRPC clients, and other “customers” of the system- dependencies and integrations with other systems- how eventual consistency is achieved across all the services- how failures in a dependency impact the behavior of the whole

POC single cluster

Para corroborar com a verificação de ganhos obtidos ao utilizar a aplicação kubecost para apresentar de forma mais clara os gastos que cada aplicação despende, foi feita a POC no cluster de stg.

Local

provider: AWS

cluster: arn:aws:eks:us-east-1:310090716792:cluster/platform-stg-eks-loggi

motivação: 

Uso do cluster kubernetes é continuo;

Diversos recursos já possuem tag para identificação de seus “donos”;

Maior conhecimento do relatório de billing para comparativo com as informações obtidas com o kubecost;

Instalação

A instalação do kubecost no cluster foi feita utilizando helm, foi seguida a instrução da documentação oficial (2) para efetuar a instalação.

É recomandado que mesmo que haja um Prometheus em uso, a primeira instalação seja feita de forma padrão - instalando o Kubecost com o bundled Prometheus (3);

E recomendado que sejam utilizados os pacotes rometheus-server & grafana mas reutilize kube-state-metrics  e node-exporter, se já existirem. Essa configuração permite o processo de instalação mais fácil, manutenção contínua mais fácil, duplicação mínima de métricas e retenção de métricas mais flexível. (4.3). 

Devido à essas recomendações o comando de instalação executado, foi:

helm install kubecost kubecost/cost-analyzer --namespace kubecost --set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" --set prometheus.nodeExporter.enabled="false" --set prometheus.serviceAccounts.nodeExporter.create="false"

AcessoPara acessar a interface do kubecost fazemos o port-forwardt (2)

kubectl port-forward --namespace kubecost deployment/kubecost-cost-analyzer 9090 file_copy

http://localhost:9090

Configuração

Storage configuration

A instalação padrão do Kubecost vem com um volume persistente de 32 Gb e um período de retenção de 15 dias para métricas do Prometheus.

  Essa configuração não foi alterada para essa POC .

  É possivel alterar esses parâmetros opções de configuração [4.1], inclusive é indicada uma fórmula para o cálculo do tamanho do disco e não é recomendado reter mais de 30 dias de dados no Prometheus para clusters maiores [4.2]

More info on Kubecost Storage [REMOVIDO]

pod primário do Kubecost (analisador de custos) contém dados de cache ETL, bem como dados de configuração do produto

Embora seja tecnicamente opcional, porque todas as configurações podem ser definidas por meio do configmap, reduz drasticamente a carga nas instalações do Prometheus/Thanos na restart/redeploy do pod [6]

Usando o Prometheus ou Grafana já existentes

O suporte ao uso de uma instalação existente do Grafana & Prometheus é oficialmente oferecida nos produtos pagos.

mas há instruções básicas de configuração na documentação [3].

Configurando Request e Limits

É recomendável que os usuários definam e/ou atualizem requests e limits de recursos antes de colocar o Kubecost em produção em escala. Essas entradas podem ser configuradas no Kubecost values.yaml para módulos Kubecost + subcharts.

Consultar a documentação   ara obter um maior detalhamento no momento de fazer essa configuração.

Configurando uma integração na nuvem

Features

Alocação de Custos (Cost Allocation) 

O kubecost permite que os gastos sejam reunidos em diversos dos conceitos nativos do Kubernetes.

Isto é, os custos podem ser agregados por namespace, pod, label, deployment, etc….

É possível também agregar os custos por conceitos organizacionais como team, application, product/project, department, ou environment - utilizando as labels nos deployments. 

Visualizar os custos de vários clusters, mesmo que estejam em várias nuvens, em uma única visualização (disponivel na versão paga).

Monitoramento unificado de custos (Unified cost monitoring) 

É possível visualizar os gastos com Kubernetes, e gastos de fora do cluster, utilizando a integração com a cloud provider, para obtermos  visibilidade completa de custos 

segundo a documentação oficial do kubecost todos os serviços da AWS, GCP e Microsoft Azure são compatíveis [5], sendo possível  visualizar gastos unificados juntando custos em tempo real do cluster Kubernetes (CPU, memória, armazenamento, rede etc.) com custos externos, por exemplo, instâncias RDS marcadas, depósitos do BigQuery ou buckets do S3.

Insights de otimização (Optimization Insights) 

O kubecost gera recomendações personalizadas para economia de gastos com a infraestrutura.

Alertas e Governança (Alerts & Governance) 

É possível definir orçamentos para níveis de team, application, etc. 

Permite a criação de alertas e relatório de modo à possibilitar às equipes permanecer dentro dos limites orçados.



aws out of cluster

[7] A integração do Kubecost aos seus dados da AWS oferece a capacidade de alocar custos fora do cluster, por exemplo, Instâncias do RDS e buckets do S3, de volta aos conceitos do Kubernetes, como namespace e implantação, bem como reconciliar os ativos do cluster com seus dados de faturamento. Este último é especialmente útil quando as equipes estão usando Reserved Instances, Savings Plans, ou Enterprise Discounts. Todos os dados de faturamento permanecem em seu cluster ao usar essa funcionalidade e não são compartilhados externamente.Leia a documentação do Cloud Integrations para obter mais informações sobre como o Kubecost se conecta com os provedores de serviços em nuvem.

Cloud Integrations

O kubecost permite que seja feita a integração com os cloud providers  por meio de suas respectivas APIs de cobrança, permitem que o Kubecost exiba os custos fora do cluster. Configurar a integração com o cloud provider permite que o Kubecost obtenha dados de cobrança adicionais. [7]

Integração multi-cloud

Essa feature está disponível apenas no plano enterprise, ela  possibilita configurar a integração na nuvem para contas em múltiplos cloud providers ou em múltiplas contas no mesmo cloud providers.

Após a configuração ser realizada, o Kubecost exibirá os assets para todas as contas configuradas e realizará a reconciliação de todos os clusters federados que tenham suas respectivas contas configuradas.

PASSOS:

Configurar os relatórios de uso e custo da nuvem;

Azure  :  deve ser configurada a exportação de dados de custo [9.1];

AWS  :  configurar a integração do relatório de uso e custo (Cost and Usage Report), passos 1-3 [7.1] 

Criar uma secret

O segredo deve conter um arquivo chamado cloud-integration.json com o seguinte formato: 

{
"azure": [],
"gcp": [],
"aws": []
}

Depois que o segredo for criado, defina .Values.kubecostProductConfigs.cloudIntegrationSecret como <SECRET_NAME> e atualize o Kubecost via Helm

Para cada provider é preciso um conjunto de configurações especificas.

 Para detalhamento completo do passo-a-passo consultar na documentação oficial [7.1].


aws cloud integrations [7.2]

Por padrão o Kubecost extrai os preços dos assets da API pública de preços da AWS, para ter informações de preços mais precisas, pode-se integrar diretamente o kubecost à conta da AWS. 

Essa integração considerará adequadamente os programas de descontos corporativos, o uso de instâncias reservadas, os Savings Plans, o uso spot e muito mais.

aws out of cluster [8]

A integração do Kubecost com a AWS possibilita a monitorar custos fora do cluster, por exemplo, Instâncias do RDS e buckets do S3..Leia a documentação do Cloud Integrations para obter mais informações sobre como o Kubecost se conecta com os provedores de serviços em nuvem.

O Kubecost utiliza as tags do AWS para alocar os custos dos recursos do AWS fora do cluster. Para alocação de recursos externo é preciso utilizar um conjunto especifico de tags - consultar documentação oficial [8] para maior detalhamento;

PASSOS

Criar um usuário de serviço

O usuário precisará de permissão para (I) criar relatório de custo e uso (Cost and Usage Report), (II) credenciais do IAM para Athena e S3 e opcionalmente (III) permissão para de adicionar e executar modelos do CloudFormation. 

não exigido acesso root na conta da AWS.

Configurar o CUR (Cost and Usage Report.)

 

Configurar Athena;

Setting up Athena 

configurar permissões do IAM

Setting up IAM permissions

 Para detalhamento completo do passo-a-passo consultar na documentação oficial [7.2].

azure cloud integrations [9]

Todos os passos para realizar a integração do kubecost com a Azure estão descrito na documentação oficial  [9.1].

aws out of cluster [9]

Conectar sua conta do Azure ao Kubecost permite visualizar as métricas do Kubernetes lado a lado com o custo dos serviços de nuvem externos, por exemplo, Serviços de Banco de Dados do Azure+ Além disso, permite que o Kubecost reconcilie os gastos medidos do Kubernetes com sua fatura real do Azure.

Para configurar os custos fora do cluster (OOC : out-of-cluster) para o Azure no Kubecost, você só precisa configurar a exportação diária de relatórios de custo para o armazenamento do Azure. Depois que os relatórios de custo forem exportados para o Armazenamento do Azure, o Kubecost os acessará por meio da API do Armazenamento do Azure para exibir seus dados de custo OOC juntamente com seus custos no cluster.

PASSOS

Exportar relatório de custo do Azure

Passo a passo detalhados disponível na documentação oficial [9.1];

Fornecer acesso à API de armazenamento do Azure

valores necessários para fornecer acesso à Azure Storage Account para onde os dados de custo estão sendo exportados podem ser encontrados no portal do Azure na conta de armazenamento para onde os dados de custo estão sendo exportados.

Tagueamento dos recursos do Azure

O Kubecost utiliza as tags do Azure para alocar os custos dos recursos do Azure fora do cluster;

Para alocação de recursos externo é preciso utilizar um conjunto especifico de tags - consultar documentação oficial [9] para maior detalhamento;

Para usar um esquema de tags alternativo ou existente na Azure, pode fornecê-los em seu values.yaml em kubecostProductConfigs.labelMappingConfigs.<aggregation>_external_label e deve-se definirkubecostProductConfigs.labelMappingConfigs.enabled = true

Kubecost utilizes Azure tagging to allocate the costs of Azure resources outside of the Kubernetes cluster to specific Kubernetes concepts, such as namespaces, pods, etc. These costs are then shown in a unified dashboard within the Kubecost interface [9].

 Mais sobre a marcação do Azure aqui

Reconciliation

A reconciliação corresponde aos ativos do cluster com os itens encontrados nos dados de cobrança extraídos do provedor de serviços de nuvem. Isso permite que o Kubecost exiba a representação mais precisa de seus gastos no cluster. Além disso, o processo de reconciliação cria ativos de rede para nós do cluster com base nas informações nos dados de cobrança. A principal desvantagem desse processo é que os provedores de serviços em nuvem têm um atraso de 6 a 24 horas na liberação dos dados de cobrança, e a reconciliação requer um dia inteiro de dados de custo para reconciliar com os ativos do cluster. Isso requer uma janela de 48 horas entre o uso de recursos e a reconciliação. Se a reconciliação for realizada nesta janela, o custo do ativo será deflacionado para o custo parcialmente completo mostrado nos dados de faturamento.

Cloud Assets

O processo Cloud Assets permite que o Kubecost extraia gastos de nuvem fora do cluster dos dados de cobrança do seu provedor de serviços de nuvem. Isso inclui todos os serviços executados pelo provedor de serviços de nuvem, além de recursos de computação fora dos clusters monitorados pelo Kubecost. Isso pode ajudar as equipes a entender melhor a proporção de gastos na nuvem fora do cluster dos quais seu uso no cluster depende. Os Cloud Assets ficam disponíveis assim que aparecem nos dados de faturamento, com o atraso de 6 a 24 horas mencionado acima, e são atualizados à medida que ficam mais completos.

aws-cloud-integrations.md [9]

O Kubecost extrai os preços dos ativos da API pública de preços da AWS por padrão. Para ter informações de preços precisas da AWS, você pode integrar diretamente à sua conta. Essa integração considerará adequadamente os Programas de descontos corporativos, o uso de instâncias reservadas, os Savings Plans, o uso spot e muito mais. Este recurso descreve as etapas necessárias para alcançar isso.

O usuário precisará das permissões necessárias para

Criar o relatório de custo e uso (Cost and Usage Report);

Credenciais do IAM para Athena e S3;

Permissão opcional

 é a capacidade de adicionar e executar modelos do CloudFormation. 

não exigido acesso root na conta da AWS.

Integração do relatório de custo e uso

Passo 1: Configurando o CUR

FYI : Anote o nome do bucket que você cria para dados CUR. Isso será usado na etapa seguinte.

  

login em https://console.aws.amazon.com/billing/home#/;

Cross-Cutting Concerns

There may be one or multiple chapters that talk about specific concerns from their specific point of view. While the entire design should have them in mind the dedicated chapters ensure that they are addressed and highlight how the design applies to them. Don’t forget to talk about authentication, logging and observability, privacy and security of user data where applicable.

Alternatives Considered

The goals in the same context and scope sometimes provide multiple alternatives. Whenever reasonable alternative paths to achieve the goals are discarded, you should add a discussion about why and how the decision to discard that alternative was made.

Referencias

1 -   

2 - how install kubecost

2.1 -   

3 -   

4 - 

4.1   

4.2 Storage configuration  

4.3 Bring your own Prometheus or Grafana  

5 -   

6 -   

7 -   

8 -  

9 -   

