>> detalhes STEP 1
# Criando relat贸rios de uso e de custo
_[Creating Cost and Usage Reports](
https://docs.aws.amazon.com/cur/latest/userguide/cur-create.html)_

Voc锚 pode usar a p谩gina Cost & Usage Reports do console Billing and Cost Management para criar Relat贸rios Cost and Usage.

馃搶 Pode levar at茅 24 horas para que a AWS comece a entregar relat贸rios ao seu bucket do Amazon S3. Ap贸s o in铆cio da entrega, a AWS atualiza os arquivos de relat贸rios de uso e custo da AWS pelo menos uma vez por dia.

## Criar relat贸rios Cost and Usage
_To create Cost and Usage Reports_


1. Fa莽a login no console do **Billing and Cost Management** em https://console.aws.amazon.com/billing/home#/

2. No painel de navega莽茫o, selecione **Cost and Usage Report**.

3. Escolha Create report (Criar relat贸rio).

4. Em Report name (Nome do relat贸rio), insira um nome para o relat贸rio

馃搶 O nome do relat贸rio deve ser 煤nico e conter apenas caracteres alfanum茅ricos! - _ . * '( )

5. Em _Additional report details_ (Detalhes adicionais do relat贸rio), selecione _Include resource IDs_ (Incluir IDs de recurso) para incluir os IDs de cada recurso individual no relat贸rio.

馃搶 A inclus茫o de IDs de recursos criar谩 itens de linha individuais para cada um de seus recursos. Isso pode aumentar significativamente o tamanho dos seus arquivos de Relat贸rios de custos e uso, com base noAWSuso do.


馃搶 Pode levar at茅 24 horas porAWSPara come莽ar a entregar relat贸rios no bucket do Amazon S3. Ap贸s o in铆cio da entrega,AWSatualiza oAWSRelat贸rios de custos e uso pelo menos uma vez por dia.

馃搶 Quando os recursos s茫o criados, a AWS atribui um ID de recurso exclusivo a cada um deles. Incluir IDs de recursos individuais em seu relat贸rio pode aumentar significativamente o tamanho do arquivo.


6. Para Data refresh settings (configura莽玫es de atualiza莽茫o de dados), selecione se deseja que os relat贸rios de uso e custo da AWS sejam atualizados se a AWS aplicar reembolsos, cr茅ditos ou taxas de suporte 脿 sua conta ap贸s finalizar sua fatura. Quando um relat贸rio 茅 atualizado, um novo relat贸rio 茅 carregado no Amazon S3.

馃搶 Muitas vezes, essas cobran莽as est茫o relacionadas com reembolsos, cr茅ditos e taxas do AWS Support.

馃搶  Selecionar essa op莽茫o atualiza automaticamente seu Relat贸rio de uso e custos quando forem detectadas cobran莽as de meses anteriores com faturas fechadas

7. Avan莽ar.

8. Para bucket do S3, escolha Configure.
    
    馃搶 Para receber os relat贸rios de uso e custo da AWS, voc锚 deve ter um bucket do Amazon S3 criado e configurado com as permiss玫es de acesso apropriadas. Voc锚 pode adicionar um bucket existente ou criar um novo.

 9. Na caixa de di谩logo _S3 bucket - required_ clique em _Configure_ , siga um destes procedimentos:

  * _Select existing bucket_ : Selecione um bucket existente na lista suspensa e escolha Next.

  * Create a bucket: selecione o bucket e a regi茫o e escolha Next.

       馃搶 Se voc锚 criar um bucket para relat贸rios de custo e uso da AWS, as configura莽玫es e permiss玫es padr茫o ser茫o aplicadas. Ap贸s a cria莽茫o do bucket, voc锚 pode atualizar as configura莽玫es e permiss玫es no console do Amazon S3.

       馃搶 Algumas regi玫es s茫o desabilitadas por padr茫o. Para criar um bucket em uma dessas regi玫es, voc锚 deve habilitar a regi茫o primeiro. Saber mais


10. Revise a pol铆tica do bucket e selecione _I have confirmed that this policy_ (Confirmei que esta pol铆tica est谩 correta) e escolha Salvar.

    Politica padr茫o aplicada

    ~~~json
    {
  "Version": "2008-10-17",
  "Id": "Policy1335892530063",
  "Statement": [
    {
      "Sid": "Stmt1335892150622",
      "Effect": "Allow",
      "Principal": {
        "Service": "billingreports.amazonaws.com"
      },
      "Action": [
        "s3:GetBucketAcl",
        "s3:GetBucketPolicy"
      ],
      "Resource": "arn:aws:s3:::kubecost-aws-cost-and-usage-report",
      "Condition": {
        "StringEquals": {
          "aws:SourceArn": "arn:aws:cur:us-east-1:701893420597:definition/*",
          "aws:SourceAccount": "701893420597"
        }
      }
    },
    {
      "Sid": "Stmt1335892526596",
      "Effect": "Allow",
      "Principal": {
        "Service": "billingreports.amazonaws.com"
      },
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::kubecost-aws-cost-and-usage-report/*",
      "Condition": {
        "StringEquals": {
          "aws:SourceArn": "arn:aws:cur:us-east-1:701893420597:definition/*",
          "aws:SourceAccount": "701893420597"
        }
      }
    }
  ]
}
    ~~~

11. Para _Report path prefix_ (Prefixo do caminho do relat贸rio), insira o prefixo do caminho do relat贸rio que deseja anexar ao nome do seu relat贸rio.

馃摋 https://docs.aws.amazon.com/enterprisebilling/6b7c01c5-b592-467e-9769-90052eaf359c/userguide/configuring-eb.html


12. Para granularidade de tempo, escolha uma das seguintes op莽玫es Time granularity : Daily

    馃搶 A granularidade de tempo na qual os dados do relat贸rio s茫o medidos e exibidos.

    馃搶 Daily:  se desejar que os itens de linha no relat贸rio sejam agregados por dia.

13. Para Report versioning (Vers茫o de relat贸rio), escolha se deseja que cada vers茫o do relat贸rio sobrescreva a vers茫o anterior do relat贸rio ou seja entregue al茅m das vers玫es anteriores. 

A substitui莽茫o de relat贸rios pode economizar nos custos de armazenamento do Amazon S3. A entrega de novas vers玫es de relat贸rios pode melhorar a capacidade de auditoria dos dados de faturamento ao longo do tempo.

>> Report versioning = Create new report version X 
>> Utilizando o Athena 茅 selecionado por padr茫o Overwrite existing report, sme a possibilidade de allterar a op莽茫o


14. Em Enable report data integration for (Habilitar integra莽茫o de dados de relat贸rio para), selecione se deseja habilitar seus relat贸rios de custo e uso para integra莽茫o com Amazon Athena, Amazon Redshift ou Amazon QuickSight. O relat贸rio 茅 compactado nos seguintes formatos:
 * Athena: formato parquet
 * Amazon Redshift ou Amazon QuickSight: compacta莽茫o .gz


15. Avan莽ar.

16. Depois de revisar as configura莽玫es do seu relat贸rio, escolha Revisar e concluir.


Voc锚 sempre pode retornar 脿 se莽茫o Relat贸rios de custo e uso do console do Billing and Cost Management para ver quando seus relat贸rios foram atualizados pela 煤ltima vez.