# [Network Traffic Cost Allocation](https://guide.kubecost.com/hc/en-us/articles/4407595973527-Network-Traffic-Cost-Allocation)

Este documento resume a alocação de custos da rede Kubecost (_Kubecost network cost allocation_), como habilitá-la e o que ela oferece.

Quando esse recurso está ativado, o Kubecost reúne métricas de tráfego de rede em combinação com custos de rede específicos do provedor para fornecer informações sobre fontes de dados de rede, bem como os custos agregados de transferências.

## Enabling Network Costs

Para ativar esse recurso, defina o seguinte parâmetro em values.yaml durante a instalação do Helm:

`networkCosts.enabled=true`

Você pode ver uma lista de opções de configuração comuns [aqui](https://github.com/kubecost/cost-analyzer-helm-chart/blob/ab384e2eb027e74b2c3e61a7e1733ffa1718170e/cost-analyzer/values.yaml#L276). Se estiver integrando com um Prometheus existente, você pode definir `networkCosts.prometheusScrape=true` e o serviço de custos de rede deve ser descoberto automaticamente.

Para estimar os recursos necessários para executar o custo da rede Kubecost, você pode visualizar nossas [métricas de benchmarking.](https://docs.google.com/document/d/10b-Ew78R90UOaZ5gXQUjU5GWZXBIy8H11RK5bbCd2EM/edit)


## Kubernetes Network Traffic Metrics
A fonte primária de métricas de rede é um pod DaemonSet hospedado em cada um dos nós em um cluster. Cada pod de daemonset usa `hostNetwork: true` para que possa aproveitar um módulo de kernel subjacente para capturar dados de rede. Os dados de tráfego de rede são coletados e o destino de qualquer rede de saída é rotulado como:

* Internet Egress: o target de destino de rede não foi identificado no cluster;
* Cross Region Egress: o target de destino da rede foi identificado, mas não na mesma região do provedor.
* Cross Zone Egress: o target de destino da rede foi identificado e fazia parte da mesma região, mas não da mesma zona.

Essas classificações são importantes porque se correlacionam com os modelos de custo de rede para a maioria dos provedores de nuvem. Para ver mais detalhes sobre essas classificações de métricas, você pode visualizar os logs do pod com o seguinte comando:

`kubectl logs kubecost-network-costs-<pod-identifier> -n kubecost`

Isso mostrará os principais endereços IP de origem e destino e bytes transferidos no nó em que esse pod está sendo executado. Para desabilitar os logs, você pode definir o helm value  `networkCosts.trafficLogging` como `false`.

## Overriding traffic classifications

## Troubleshooting

## Feature Limitations
* Hoje este recurso é suportado em imagens baseadas em Unix com conntrack
* Testado ativamente em relação ao GCP, AWS e Azure
* Daemonsets têm endereços IP compartilhados em determinados clusters
