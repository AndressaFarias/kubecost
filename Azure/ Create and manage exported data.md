# [Tutorial: Create and manage exported data](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-export-acm-data?tabs=azure-portal)

... você pode criar uma tarefa recorrente que exporte automaticamente seus dados do Cost Management para o armazenamento do Azure diariamente, semanalmente ou mensalmente. Os dados exportados estão no formato CSV e contêm todas as informações coletadas pelo Cost Management. 

## Prerequisites

* Owner - pode criar, modificar ou excluir exportações agendadas para uma assinatura;
* Contributor - Podem criar, modificar ou excluir suas próprias exportações programadas. Pode modificar o nome das exportações programadas criadas por outras pessoas
* Reader - Podem agendar exportações para as quais têm permissão.

:alert: Se você tiver uma nova assinatura, não poderá usar os recursos do Gerenciamento de Custos imediatamente. Pode levar até 48 horas para que você possa usar todos os recursos do Cost Management.

## Sign in to Azure

## Create a daily export
(_Criar uma exportação diária_)

### Portal
Para criar ou exibir uma exportação de dados ou agendar uma exportação, escolha um escopo no portal do Azure e selecione __Cost analysis__ no menu. Por exemplo, navegue até __Subscriptions__, selecione uma assinatura na lista e selecione __Cost analysis__ no menu. Na parte superior da página __Cost analysis__, selecione __Settings__ e, em seguida, __Exports__.

1. Selecione __Add__ e digite um nome para a exportação;

2. Para a __Metric__, custo real são os custos totais de uso e compra para o período atual conforme são acumulados e serão exibidos em sua fatura. Os custos amortizados são custos fixos por dia do mês para contabilizar os picos devido aos custos de compra de reservas. Faça uma seleção:
    * __Actual cost__ (Usage and Purchases) (Custo real (uso e compras)) - Selecione para exportar o uso e as compras padrão
    * __Amortized cost__ (Usage and Purchases) (Custo amortizado (uso e compras)) - Selecione para exportar custos amortizados para compras como reservas do Azure.

3. Para __Export type__ (Tipo de exportação), faça uma seleção:
    * __Daily export of month-to-date costs__ (Exportação diária dos custos do mês) - Fornece um novo arquivo de exportação diariamente para seus custos mensais. Os dados mais recentes são agregados de exportações diárias anteriores.

    [...]

4. Especifique a subscription para sua conta de armazenamento do Azure e selecione um resource group ou crie um novo.

5. Selecione o nome da storage account ou crie uma nova
    * __storage account__ : A storage account onde os dados devem ser exportados

6. Selecione o local (azure region)

7. Especifique o storage container e o caminho (directory) para o qual você gostaria que o arquivo de exportação fosse.