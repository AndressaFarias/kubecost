# Azure Cloud Integration

Conectar sua conta do Azure ao Kubecost permite visualizar as métricas do Kubernetes side-by-side (lado a lado) com o custo dos serviços de nuvem externos, por exemplo, Azure Database Services. Além disso, permite que o Kubecost reconcilie os gastos medidos do Kubernetes com sua fatura real do Azure. Isso dá às equipes que executam o Kubernetes uma visão completa e precisa dos custos. Leia a documentação do [Cloud Integrations](https://guide.kubecost.com/hc/en-us/articles/4412369153687) para obter mais informações sobre como o Kubecost se conecta com os provedores de serviços em nuvem. 


Para configurar os custos fora do cluster (out-of-cluster - OOC) para o Azure no Kubecost, você só precisa configurar a exportação diária de relatórios de custo para o armazenamento do Azure. Depois que os relatórios de custo forem exportados para o Armazenamento do Azure, o Kubecost os acessará por meio da API do Armazenamento do Azure para exibir seus dados de custo OOC juntamente com seus custos no cluster.


>> Um repositório do github com arquivos de amostra usados ​​nas instruções abaixo pode ser encontrado aqui: https://github.com/kubecost/poc-common-configurations/tree/main/azure


## Step 1: Export Azure Cost Report
Siga este guia anotando o nome que você usa para o relatório de custo exportado e selecione a opção diária do mês até a data de como os relatórios serão criados. [Tutorial: Create and manage exported data](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-export-acm-data?tabs=azure-portal).

Levará algumas horas para gerar o primeiro relatório, após o qual o Kubecost poderá usar a API de armazenamento do Azure para extrair esses dados.

> **NOTE** : se você tiver dados confidenciais em uma conta de armazenamento do Azure e não quiser conceder acesso a eles, crie uma conta de armazenamento do Azure separada para armazenar sua exportação de dados de custo.


## Step 2: Provide Access to Azure Storage API

Os valores necessários para fornecer acesso à Azure Storage Account (conta de armazenamento do Azure) para onde os dados de custo estão sendo exportados podem ser encontrados no portal do Azure na conta de armazenamento para onde os dados de custo estão sendo exportados.

* `<SUBSCRIPTION_ID>` : é o id da assinatura para a qual os arquivos exportados estão sendo gerados.
    * Entre no portal do Azure. > Abaixo do título de serviços do Azure, selecione Assinaturas. Se você não vir Assinaturas aqui, use a caixa de pesquisa para encontrá-la.

* `<STORAGE_ACCOUNT_NAME>` : é o nome da conta de armazenamento em que o CSV exportado está sendo armazenado.


* `<STORE_ACCESS_KEY>` : pode ser encontrado selecionando a opção “Access Keys” na barra lateral de navegação e selecionando “Show Keys”. Usar qualquer uma das duas chaves funcionará. (na storage criada)

* `<REPORT_CONTAINER_NAME>` : é o nome que você escolhe para o relatório de custo exportado ao configurá-lo. Este é o nome do contêiner onde os relatórios de custo CSV são salvos em sua conta de armazenamento.

* `<AZURE_CONTAINER_PATH>` : é um valor opcional que deve ser usado se houver mais de um relatório de cobrança exportado para o contêiner configurado. O caminho fornecido deve ter apenas uma exportação de faturamento porque o kubecost recuperará o relatório de faturamento mais recente de um determinado mês encontrado no caminho.


* `<<AZURE_CLOUD>>` : é um valor opcional que denota a nuvem onde existe a conta de armazenamento, os valores possíveis são `public` e `gov`. O padrão é `público`.


Com esses valores em mãos, agora você pode fornecê-los ao Kubecost para permitir o acesso à API de armazenamento do Azure.

Para criar esse segredo, você precisará criar um arquivo JSON que deve ser denominado azure-storage-config.json com o seguinte formato:

~~~json
{
  "azureSubscriptionID": "<SUBSCRIPTION_ID>",
  "azureStorageAccount": "<STORAGE_ACCOUNT_NAME>",
  "azureStorageAccessKey": "<STORE_ACCESS_KEY>",
  "azureStorageContainer": "<REPORT_CONTAINER_NAME>",
  "azureContainerPath": "<AZURE_CONTAINER_PATH>",
  "azureCloud": "<AZURE_CLOUD>"
}
~~~

Depois de preencher os valores, use este comando para criar o segredo: `kubectl create secret generic <SECRET_NAME> --from-file=azure-storage-config.json -n kubecost`

Depois que o segredo for criado, defina `.Values.kubecostProductConfigs.azureStorageSecretName` como `<SECRET_NAME>` e atualize o Kubecost via Helm, outros valores relacionados ao Armazenamento do Azure (consulte outro método) não devem ser definidos.

Após uma configuração bem-sucedida do Azure fora dos custos de cluster, ao abrir a página Assets dos custos do Kubecost, os custos serão divididos por serviço e não haverá mais um banner na parte superior da tela informando que OOC não está configurado.

`helm upgrade kubecost kubecost/cost-analyzer --namespace kubecost --reuse-values \
--set kubecostProductConfigs.azureStorageSecretName="kubecost-azure-provider-access"

## Step 3: Tagging Azure resources

O Kubecost utiliza a marcação do Azure para alocar os custos dos recursos do Azure fora do cluster Kubernetes para conceitos específicos do Kubernetes, como namespaces, pods etc. Esses custos são mostrados em um painel unificado na interface Kubecost.

Para alocar recursos externos do Azure para um conceito do Kubernetes, use o seguinte esquema de nomenclatura de marca:


## Troubleshooting and Debugging
Se você não conseguiu ver seus custos OOC no painel, aqui estão algumas etapas que você pode seguir para tentar resolver o problema. Primeiro, verifique se você usou os valores corretos no arquivo JSON usado para criar seu segredo. Além disso, se não houver custos no cluster para um dia específico, o custo OOC também não será exibido para esse dia.

