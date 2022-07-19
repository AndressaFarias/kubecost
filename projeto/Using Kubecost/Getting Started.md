# Getting Started
Bem-vindo ao Kubecost! Esta página fornece configurações de produtos comumente usadas e visões gerais de recursos para ajudá-lo a começar a trabalhar após a instalação do produto Kubecost.

Configuration

* Setting up a cloud integration
* Product configuration at install-time
* Configuring metric storage
Setting requests & limits
Using an existing Prometheus installation
Using an existing Grafana installation
Using an existing node exporter installation
Exposing Kubecost with an Ingress
Deploying Kubecost without persistent volumes
Next Steps

Measure cluster cost efficiency
Cost monitoring best practices
Understanding cost allocation metrics


# [Overview](https://guide.kubecost.com/hc/en-us/articles/4407595947799-Getting-Started)

Existem muitos métodos para configurar o Kubecost. Uma simples instalação do leme fornecerá a maioria das funcionalidades para entender o que o Kubecost pode fazer. Quando você não passa nenhum valor para a instalação do leme, muitas das personalizações abaixo ficam disponíveis na guia de configurações.

Por padrão, o Kubecost detectará o provedor de nuvem onde está instalado e obterá lista de preços para nodes, armazenamento e LoadBalancers no Azure, AWS e GCP.

## Use cloud-integration(s) for Accurate Billing Data (_Use a(s) integração(ões) na nuvem para dados de cobrança precisos_)

Embora a instalação básica do leme seja útil para entender o valor que o Kubecost fornece, a maioria desejará implantar com uma infraestrutura como modelo de código. Existem muitos métodos para fornecer ao Kubecost as contas/privilégios de serviço necessários. Geralmente, recomendamos o uso dos vários guias de integração na nuvem abaixo.

Ao concluir a integração na nuvem com cada provedor, o Kubecost pode reconciliar os custos com sua fatura real da nuvem para refletir os descontos corporativos, preços do mercado spot, descontos por compromisso e muito mais.

A integração na nuvem também permite visualizar as métricas de custo do Kubernetes lado a lado com o custo dos serviços de nuvem externos, por exemplo, S3, BigQuery, Serviços de Banco de Dados do Azure.

* [AWS cloud-integration](https://guide.kubecost.com/hc/en-us/articles/4407595928087)
* [Azure cloud-integration](https://guide.kubecost.com/hc/en-us/articles/4407595936023)
* [GCP cloud-integration]

## Additional Considerations (_Considerações adicionais_)

As seções restantes são opcionais e podem ser úteis para casos de uso específicos.


**Product configuration at install-time**
O Kubecost tem várias opções de configuração do produto que você pode especificar no momento da instalação para minimizar o número de alterações de configurações necessárias na interface do usuário do produto. Isso simplifica a reimplantação do Kubecost. Esses valores podem ser configurados em `kubecostProductConfigs` em nosso [values.yaml](https://github.com/kubecost/cost-analyzer-helm-chart/blob/bb8bcb570e6c52db2ed603f69691ac8a47ff4a26/cost-analyzer/values.yaml#L335). Esses parâmetros são passados ​​para um ConfigMap que o Kubecost detecta e grava em seu /var/configs.


**Storage configuration**
A instalação padrão do Kubecost vem com um volume persistente de 32 Gb e um período de retenção de 15 dias para métricas do Prometheus. Esse espaço é suficiente para reter dados de aproximadamente 300 pods, dependendo da contagem exata de nós e contêineres. Consulte Helm chart do Kubecost [opções de configuração](https://github.com/kubecost/cost-analyzer-helm-chart) para ajustar o período de retenção e o tamanho do armazenamento. Para determinar o tamanho do disco apropriado, você pode usar esta fórmula para aproximar: ``` required_disk_space = retenção_time_minutes * ingested_samples_per_minutes * bytes_per_sample `. Onde as amostras ingeridas podem ser medidas como a média em um período recente, por exemplo. `sum(avg_over_time(scrape_samples_post_metric_relabeling[24h]))`. Em média, o Prometheus usa cerca de 1,5-2 bytes por amostra. Portanto, ingerir 1 milhão de amostras por minuto e reter por 15 dias (21.600 minutos) exigiria cerca de 40 GB. Recomenda-se adicionar mais 20-30% de capacidade para headroom e WAL. Mais informações sobre dimensionamento de disco [aqui](https://prometheus.io/docs/prometheus/latest/storage/#operational-aspects).

>> **NOTE** **Observação:** não recomendamos reter mais de 30 dias de dados no Prometheus para clusters maiores. Para retenção de dados de longo prazo, entre em contato conosco (support@kubecost.com) sobre o Kubecost com armazenamento durável ativado. [Mais informações sobre Kubecost Storage](/storage.md)


**Setting Requests & Limits**
É recomendável que os usuários definam e/ou atualizem solicitações e limites de recursos antes de colocar o Kubecost em produção em escala. Essas entradas podem ser configuradas no Kubecost [values.yaml](https://github.com/kubecost/cost-analyzer-helm-chart/blob/master/cost-analyzer/values.yaml) para módulos Kubecost + subcharts. Os valores exatos recomendados para esses parâmetros dependem do tamanho do cluster, dos requisitos de disponibilidade e do uso do produto Kubecost. Os valores sugeridos para cada contêiner podem ser encontrados no próprio Kubecost na página de namespace. Mais informações sobre essas recomendações estão disponíveis [aqui](http://blog.kubecost.com/blog/requests-and-limits/). Na prática, recomendamos executar o Kubecost por até 7 dias em um cluster de produção e, em seguida, ajustar as solicitações/limites de recursos com base no consumo de recursos. Entre em contato a qualquer momento para support@kubecost.com se pudermos ajudar a fornecer mais orientações.


**Using an existing node exporter**
Para equipes que já executam o node exporter de nó na porta padrão, nosso exportador de nó empacotado pode permanecer em um estado "Pendente". Opcionalmente, você pode usar um DaemonSet do exportador de nós existente definindo as opções de configuração do gráfico de leme `prometheus.nodeExporter.enabled` e `prometheus.serviceAccounts.nodeExporter.create` Kubecost como `false`. Mais opções de configuração mostradas [aqui](https://github.com/kubecost/cost-analyzer-helm-chart) 

>> **NOTE**: isso requer que o endpoint do node exporter de nó existente esteja visível no namespace em que o Kubecost está instalado.


**Deploying Kubecost without persistent volumes**
Opcionalmente, você pode passar as seguintes flags do Helm para instalar o Kubecost e suas dependências empacotadas sem nenhum Volume Persistente. Observe que sempre que o pod do servidor Prometheus for reiniciado, todos os dados históricos de cobrança serão perdidos, a menos que o Thanos ou outro armazenamento de longo prazo esteja ativado no produto Kubecost. ``` --set prometheus.alertmanager.persistentVolume.enabled=false --set prometheus.pushgateway.persistentVolume.enabled=false --set prometheus.server.persistentVolume.enabled=false --set persistVolume.enabled=false ```


**Cost Optimization**
Para as equipes interessadas em reduzir os custos do Kubernetes, vimos que é benéfico primeiro entender como os recursos provisionados foram usados. Há dois conceitos principais para começar: eficiência de recursos do pod e custos de inatividade do cluster.
   1. A eficiência de recursos em uma janela de tempo é definida como a utilização de recursos nessa janela de tempo versus a solicitação de recurso na mesma janela de tempo. É ponderado pelo custo e definido da seguinte forma: ((Uso de CPU / CPU solicitado) * Custo de CPU) + (Uso de RAM / RAM solicitado) * Custo de RAM) / (Custo de RAM + Custo de CPU)) Uso de CPU = taxa(container_cpu_usage_seconds_total) ao longo da janela de tempo Uso de RAM = avg(container_memory_working_set_bytes) ao longo da janela de tempo Por exemplo: se um pod está solicitando 2 CPUs e 1 Gb, usando 500mCPU e 500 MB, a CPU no nó custa $ 10/CPU e a RAM no nó custa $ 1/GB , temos ((0,5/2) * 20 + (0,5/1) * 1) / (20 + 1) = 5,5 / 21 = 26%;

   2. O custo idle é definido como a diferença entre o custo dos recursos alocados e o custo do hardware em que são executados. A alocação é definida como o máximo de uso e solicitações. Portanto, os custos ociosos também podem ser considerados como o custo do espaço em que o agendador do kubernetes pode adicionar pods sem interromper nenhuma carga de trabalho, mas não está atualmente. A inatividade pode ser cobrada de pods com base no custo ponderado ou visualizada como um item de linha separado. O padrão mais comum de redução de custos é pedir aos proprietários de serviços que ajustem a eficiência de seus pods e, em seguida, recuperar espaço definindo custos de inatividade desejados.

O produto Kubecost (página Cluster Overview ) fornece uma visão desses dados para uma avaliação inicial da eficiência dos recursos e do custo do desperdício. Com uma compreensão geral de gastos ociosos e eficiência de recursos, você terá uma melhor noção de onde concentrar os esforços para obter ganhos de eficiência. Cada tipo de recurso agora pode ser ajustado para o seu negócio. A maioria das equipes que vimos acaba mirando ocioso nas seguintes faixas. * CPU: 50%-65% * Memória: 45%-60% * Armazenamento: 65%-80% Os números alvo são altamente dependentes da previsibilidade e distribuição do seu uso de recursos (por exemplo, P99 vs mediana), o impacto da alta utilização em suas métricas principais de produtos/negócios e muito mais. Embora a utilização de recursos muito baixa seja um desperdício, a utilização muito alta pode levar a aumentos de latência, problemas de confiabilidade e outros comportamentos negativos. As metas de eficiência podem depender dos SLAs do aplicativo - consulte nossas notas sobre [solicitar dimensionamento correto](https://github.com/kubecost/docs/blob/main/api-request-right-sizing.md) para mais detalhes.