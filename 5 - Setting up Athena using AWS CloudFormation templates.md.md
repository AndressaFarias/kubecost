>> detalhes STEP 2

# Configurar o Athena usando template AWS CloudFormation
📙 [Setting up Athena using AWS CloudFormation templates](https://docs.aws.amazon.com/cur/latest/userguide/use-athena-cf.html)

Configurando o Athena usando modelos do AWS CloudFormation

🛑 **Important**
O AWS CloudFormation não oferece suporte a recursos entre regiões. Se você planeja usar um AWS CloudFormation template, você deve criar todos os recursos na mesma AWS Região. A região deve ser compatível com os seguintes serviços:
* AWS Lambda
* Amazon Simple Storage Service (Amazon S3)
* AWS Glue
* Amazon Athena

Para simplificar e automatizar a integração de seus relatórios de Cost and Usage com o Athena, a AWS fornece um yemplate do AWS CloudFormation com vários recursos importantes junto com os relatórios que você configurou para a integração com o Athena. O template do AWS CloudFormation inclui um AWS Glue crawler, AWS Glue database e um AWS Lambda events.


O processo de configuração da integração do Athena usando o AWS CloudFormation remove todos os eventos do Amazon S3 que seu bucket já possa ter. Isso pode afetar negativamente quaisquer processos baseados em eventos existentes que você tenha para um relatório existente do AWS CUR. É altamente recomendável que você crie um novo bucket do Amazon S3 e um novo relatório do AWS CUR para usar com o Athena.

Antes de usar um modelo do CloudFormation para automatizar a integração do Athena, certifique-se de fazer o seguinte:

* Crie um novo bucket do Amazon S3 para seus relatórios. Para obter mais informações, consulte Criar um bucket no Guia do usuário do Amazon S3.

* Crie um novo relatório para usar com o Athena. Durante o processo de configuração, para Habilitar integração de dados de relatório para, escolha Athena.

* Aguarde até que o primeiro relatório seja entregue ao seu bucket do Amazon S3. Pode levar até 24 horas para a AWS entregar seu primeiro relatório.

## Usando o template do Athena AWS CloudFormation** 
1. Abra o console do Amazon S3 em https://console.aws.amazon.com/s3/.

2. Na lista de buckets, escolha o bucket em que você escolheu receber seu relatório do AWS CUR.

3. Escolha o prefixo do caminho do relatório (prefixo-do-caminho-do-relatório/). Em seguida, escolha o nome do seu relatório (your-report-name/).

4. Escolha o arquivo de modelo `.yml`;

5. Escolha **Object actions** e, em seguida, escolha **Download**.

6. Abra o console do AWS CloudFormation em https://console.aws.amazon.com/cloudformation.

7. Se você nunca usou o AWS CloudFormation antes, escolha **Create New Stack**. Caso contrário, escolha Create Stack..
    * Selecione **With new Resources**

8. Em **Prepare template**, escolha **Template is ready**.

9. Em **Template source**, escolha **Upload a template file**.

10. Escolha **Choose file**.

11. Escolha o template `.yml` baixado e escolha **Abrir**.

12. **Next**.

13. Para Stack name, insira um nome para seu template e escolha **Next**. 


14. **Next**.

15. Na parte inferior da página, selecione **I acknowledge that AWS CloudFormation might create IAM resources** (Reconheço que o AWS CloudFormation pode criar recursos do IAM.)

Este template cria os seguintes recursos:

   * Três IAM roles
   * Um AWS Glue database
   * Um AWS Glue crawler
   * Dois Lambda functions
   * Um Amazon S3 notification

16. Escolha **Create Stack**


