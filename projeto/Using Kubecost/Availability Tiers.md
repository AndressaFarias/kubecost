# [Availability Tiers](https://guide.kubecost.com/hc/en-us/articles/4407595926423-Availability-Tiers)

Os níveis de disponibilidade afetam as recomendações de capacidade, classificações de integridade e muito mais no produto Kubecost. Por exemplo, os trabalhos de produção recebem recomendações de solicitação de recursos mais altas do que as cargas de trabalho de desenvolvimento. Outro exemplo é que as pontuações de integridade para cargas de trabalho de alta disponibilidade são fortemente penalizadas por não terem várias réplicas disponíveis.

Hoje, nosso produto suporta os seguintes níveis:

|| Tier || Priority || Default ||
|`Highly Available` ou `Critical` | 0 | Se true, recomendações e pontuações de integridade priorizam fortemente a disponibilidade. Este é o nível padrão se nenhum for fornecido. |
| `Production` | 1 | Destinado a trabalhos de produção que não são necessariamente de missão crítica.| 
| `Staging` ou `Dev` | 2 | Destinado a recursos experimentais ou de desenvolvimento. Redundância ou disponibilidade não é uma prioridade alta.|

Para aplicar uma camada de namespace, adicione um rótulo de namespace de camada para refletir o valor desejado.
