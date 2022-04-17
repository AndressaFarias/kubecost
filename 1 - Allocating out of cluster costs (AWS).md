https://docs.kubecost.com/aws-out-of-cluster.html

A integração do Kubecost com seus dados da AWS oferece a capacidade de alocar custos fora do cluster, por exemplo, instâncias do RDS e buckets do S3, voltar aos conceitos do Kubernetes, como namespace e implantação, bem como reconciliar os ativos do cluster com seus dados de faturamento. O último é especialmente útil quando as equipes estão usando Reserved Instances, Savings Plans ou Enterprise Discounts. Todos os dados de faturamento permanecem em seu cluster ao usar essa funcionalidade e não são compartilhados externamente. Leia a documentação do [Cloud Integrations](https://github.com/kubecost/docs/blob/master/cloud-integration.md) para obter mais informações sobre como o Kubecost se conecta com os provedores de serviços em nuvem.

O guia a seguir fornece as etapas necessárias para habilitar a alocação de custos fora do cluster e preços precisos, por exemplo, Alocação de preço da Reserved Instance. Em uma organização com várias contas, todas as etapas a seguir precisarão ser concluídas na conta do pagador.

Etapa 1: criar um relatório de uso e custo da AWS e integrá-lo ao Kubecost

[Siga nosso guia para integrações na nuvem](https://github.com/kubecost/docs/blob/master/aws-cloud-integrations.md)

DOC :: Cost and Usage Report Integration

