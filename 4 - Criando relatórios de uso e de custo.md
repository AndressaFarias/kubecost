>> detalhes STEP 1
# Criando relatórios de uso e de custo
_[Creating Cost and Usage Reports](
https://docs.aws.amazon.com/cur/latest/userguide/cur-create.html)_

Você pode usar a página Cost & Usage Reports do console Billing and Cost Management para criar Relatórios Cost and Usage.

📌 Pode levar até 24 horas para que a AWS comece a entregar relatórios ao seu bucket do Amazon S3. Após o início da entrega, a AWS atualiza os arquivos de relatórios de uso e custo da AWS pelo menos uma vez por dia.

## Criar relatórios Cost and Usage
_To create Cost and Usage Reports_


1. Faça login no console do **Billing and Cost Management** em https://console.aws.amazon.com/billing/home#/

2. No painel de navegação, selecione **Cost and Usage Report**.

3. Escolha Create report (Criar relatório).

4. Em Report name (Nome do relatório), insira um nome para o relatório

📌 O nome do relatório deve ser único e conter apenas caracteres alfanuméricos! - _ . * '( )

5. Em _Additional report details_ (Detalhes adicionais do relatório), selecione _Include resource IDs_ (Incluir IDs de recurso) para incluir os IDs de cada recurso individual no relatório.

📌 A inclusão de IDs de recursos criará itens de linha individuais para cada um de seus recursos. Isso pode aumentar significativamente o tamanho dos seus arquivos de Relatórios de custos e uso, com base noAWSuso do.


📌 Pode levar até 24 horas porAWSPara começar a entregar relatórios no bucket do Amazon S3. Após o início da entrega,AWSatualiza oAWSRelatórios de custos e uso pelo menos uma vez por dia.

📌 Quando os recursos são criados, a AWS atribui um ID de recurso exclusivo a cada um deles. Incluir IDs de recursos individuais em seu relatório pode aumentar significativamente o tamanho do arquivo.


6. Para Data refresh settings (configurações de atualização de dados), selecione se deseja que os relatórios de uso e custo da AWS sejam atualizados se a AWS aplicar reembolsos, créditos ou taxas de suporte à sua conta após finalizar sua fatura. Quando um relatório é atualizado, um novo relatório é carregado no Amazon S3.

📌 Muitas vezes, essas cobranças estão relacionadas com reembolsos, créditos e taxas do AWS Support.

📌  Selecionar essa opção atualiza automaticamente seu Relatório de uso e custos quando forem detectadas cobranças de meses anteriores com faturas fechadas

7. Avançar.

8. Para bucket do S3, escolha Configure.
    
    📌 Para receber os relatórios de uso e custo da AWS, você deve ter um bucket do Amazon S3 criado e configurado com as permissões de acesso apropriadas. Você pode adicionar um bucket existente ou criar um novo.

 9. Na caixa de diálogo _S3 bucket - required_ clique em _Configure_ , siga um destes procedimentos:

  * _Select existing bucket_ : Selecione um bucket existente na lista suspensa e escolha Next.

  * Create a bucket: selecione o bucket e a região e escolha Next.

       📌 Se você criar um bucket para relatórios de custo e uso da AWS, as configurações e permissões padrão serão aplicadas. Após a criação do bucket, você pode atualizar as configurações e permissões no console do Amazon S3.

       📌 Algumas regiões são desabilitadas por padrão. Para criar um bucket em uma dessas regiões, você deve habilitar a região primeiro. Saber mais


10. Revise a política do bucket e selecione _I have confirmed that this policy_ (Confirmei que esta política está correta) e escolha Salvar.

    Politica padrão aplicada

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

11. Para _Report path prefix_ (Prefixo do caminho do relatório), insira o prefixo do caminho do relatório que deseja anexar ao nome do seu relatório.

📗 https://docs.aws.amazon.com/enterprisebilling/6b7c01c5-b592-467e-9769-90052eaf359c/userguide/configuring-eb.html


12. Para granularidade de tempo, escolha uma das seguintes opções Time granularity : Daily

    📌 A granularidade de tempo na qual os dados do relatório são medidos e exibidos.

    📌 Daily:  se desejar que os itens de linha no relatório sejam agregados por dia.

13. Para Report versioning (Versão de relatório), escolha se deseja que cada versão do relatório sobrescreva a versão anterior do relatório ou seja entregue além das versões anteriores. 

A substituição de relatórios pode economizar nos custos de armazenamento do Amazon S3. A entrega de novas versões de relatórios pode melhorar a capacidade de auditoria dos dados de faturamento ao longo do tempo.

>> Report versioning = Create new report version X 
>> Utilizando o Athena é selecionado por padrão Overwrite existing report, sme a possibilidade de allterar a opção


14. Em Enable report data integration for (Habilitar integração de dados de relatório para), selecione se deseja habilitar seus relatórios de custo e uso para integração com Amazon Athena, Amazon Redshift ou Amazon QuickSight. O relatório é compactado nos seguintes formatos:
 * Athena: formato parquet
 * Amazon Redshift ou Amazon QuickSight: compactação .gz


15. Avançar.

16. Depois de revisar as configurações do seu relatório, escolha Revisar e concluir.


Você sempre pode retornar à seção Relatórios de custo e uso do console do Billing and Cost Management para ver quando seus relatórios foram atualizados pela última vez.