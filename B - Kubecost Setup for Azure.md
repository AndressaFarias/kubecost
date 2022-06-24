# Kubecost Setup for Azure

## Overview 
Este repositório foi projetado para ser um guia fácil para as configurações mais comuns do Kubecost no Azure. Ele não substitui nossa [documentação publicada](https://guide.kubecost.com/hc/en-us), que terá detalhes para muitos outros casos de uso.


## Uso (Usage)

Os arquivos de configuração (yaml/json) possuem espaços reservados para as variáveis ​​necessárias. Eles estão listados abaixo para evitar esforços duplicados. Os valores de amostra serão semelhantes aos seus.

As variáveis ​​abaixo são indicadas assim:

* `variable: sample-value` // `variável: valor-de-amostra`

Basta substituir o `sample-value` pelo seu. O link na parte superior de cada seção levará você à documentação do Kubecost com mais detalhes.


Depois de atualizar os valores correspondentes nos arquivos json e yaml neste repositório, siga o guia de configuração: [Enterprise Setup](https://github.com/kubecost/poc-common-configurations/blob/main/azure/README-enterprise.md)


## Variáveis ​​Obrigatórias (Required Variables)

### Cluster Name/ID (values*.yaml)

Observe que há dois locais em que isso é usado, em kubecostProductConfigs.clusterName e prometheus.server.global.external_labels.cluster_id


