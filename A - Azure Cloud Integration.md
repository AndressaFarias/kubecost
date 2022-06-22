# Azure Cloud Integration

Conectar sua conta do Azure ao Kubecost permite visualizar as métricas do Kubernetes side-by-side (lado a lado) com o custo dos serviços de nuvem externos, por exemplo, Azure Database Services. Além disso, permite que o Kubecost reconcilie os gastos medidos do Kubernetes com sua fatura real do Azure. Isso dá às equipes que executam o Kubernetes uma visão completa e precisa dos custos. Leia a documentação do [Cloud Integrations](https://guide.kubecost.com/hc/en-us/articles/4412369153687) para obter mais informações sobre como o Kubecost se conecta com os provedores de serviços em nuvem. 


Para configurar os custos fora do cluster (out-of-cluster  - OOC) para o Azure no Kubecost, você só precisa configurar a exportação diária de relatórios de custo para o armazenamento do Azure. Depois que os relatórios de custo forem exportados para o Armazenamento do Azure, o Kubecost os acessará por meio da API do Armazenamento do Azure para exibir seus dados de custo OOC juntamente com seus custos no cluster.


>> Um repositório do github com arquivos de amostra usados ​​nas instruções abaixo pode ser encontrado aqui: https://github.com/kubecost/poc-common-configurations/tree/main/azure


## Step 1: Export Azure Cost Report
Siga este guia anotando o nome que você usa para o relatório de custo exportado e selecione a opção diária do mês até a data de como os relatórios serão criados.
[Tutorial: Create and manage exported data](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-export-acm-data?tabs=azure-portal)