>> Adicional Step 3

# Feed de dados da instância spot
(_Spot Instance data feed_)

Para compreender as cobranças relativas às suas instâncias spot, o Amazon EC2 fornece um feed de dados que descreve o uso que você faz de sua instância spot e a definição de preços. Esse feed de dados é enviado a um bucket do Amazon S3 que você especifica ao assinar um feed de dados.


O feed de dados chega em seu bucket geralmente uma vez por hora, e cada hora de uso geralmente é coberto em um único arquivo de dados. Esses arquivos são compactados (gzip) antes de serem entregues ao seu bucket. O Amazon EC2 pode gravar vários arquivos em uma determinada hora de uso quando os arquivos estiverem muito grandes (por exemplo, quando o conteúdo dos arquivos para a hora ultrapassar 50 MB antes da compactação).


📌 NOTA
>> Se você não tiver uma instância spot em execução em uma hora específica, não receberá um arquivo de feed de dados nessa hora.


O feed de dados da instância spot é compatível em todas as regiões AWS, exceto China (Pequim), China (Ningxia), AWS GovCloud (EUA) e as regiões que estão desabilitadas por padrão.


## Nome e formato de arquivo do feed de dados

O nome de arquivo do feed de dados de instância spot usa o seguinte formato (com a data e a hora em UTC):


`bucket-name.s3.amazonaws.com/optional-prefix/aws-account-id.YYYY-MM-DD-HH.n.unique-id.gz`

Por exemplo, se o nome do bucket for **my-bucket-name** e o prefixo for **my-prefix**, os nomes dos arquivos serão semelhantes ao seguinte:

`my-bucket-name.s3.amazonaws.com/my-prefix/111122223333.2019-03-17-20.001.pwBdGTJG.gz`


Para mais informações sobre os nomes de bucket, consulte [Regras de nomeação de bucket](https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/BucketRestrictions.html#bucketnamingrules) no Guia do usuário do _Amazon Simple Storage Service_.

Os arquivos de feed de dados de instância spot são delimitados por tabulação. Cada linha no arquivo de dados corresponde a uma hora de instância e contém os campos listados na tabela a seguir.

* Timestamp

O timestamp usado para determinar o preço cobrado pelo uso dessa instância.

* UsageType

O tipo de uso e instância que está sendo cobrado. Para `m1.small` Instâncias spot, este campo está definido como `SpotUsage`. Para todos os outros tipos de instância, esse campo é definido como `SpotUsage:`{instance-type}. 

Por exemplo: _SpotUsage:c1.medium_ 


* Operation

O produto que está sendo cobrado. Nas Instâncias spot do Linux, este campo é definido como 'RunInstances`. Nas Instâncias spot do Windows, este campo é definido como `RunInstances:0002`. O uso de spot é agrupado de acordo com a zona de disponibilidade.


* InstanceID

O ID da instância spot que gerou este uso de instância.


* MyBidID

O ID da solicitação de instância spot que gerou este uso de instância.


* MyMaxPrice

O preço máximo especificado para essa solicitação de spot.


* MarketPrice

O preço spot na hora especificada no campo Timestamp.


* Charge

O preço cobrado por este uso de instância.


* Version

A versão incluída no nome do arquivo de feed de dados para esse registro.


## Requisitos do bucket do Amazon S3

Ao assinar o feed de dados, você deve especificar um bucket do Amazon S3 pra armazenar os arquivos do feed de dados. Antes de escolher um bucket do Amazon S3 para o feed de dados, considere o seguinte:

* Você deve ter a permissão `FULL_CONTROL` para o bucket, incluindo permissão para as ações `s3:GetBucketAcl` e `s3:PutBucketAcl`.

Se você for o proprietário do bucket, terá essa permissão por padrão. Caso contrário, o proprietário do bucket deve conceder essa permissão à sua conta da AWS.


* Quando você assina um feed de dados, essas permissões são usadas para atualizar a ACL do bucket para conceder à conta de feed de dados da AWS a permissão FULL_CONTROL. A conta de feed de dados da AWS grava arquivos de feed de dados no bucket. Se sua conta não tiver as permissões necessárias, os arquivos de feed de dados não poderão ser gravados no bucket.


📌 NOTA
>> Se você atualizar o ACL e eliminar as permissões para a conta do feed de dados da AWS, os arquivos de feed de dados não poderão ser gravados no bucket. Você deve assinar novamente o feed de dados para receber arquivos de feed de dados.


* Cada arquivo do feed de dados tem sua própria ACL (separada da ACL do bucket). O proprietário do bucket tem a permissão `FULL_CONTROL` para os arquivos de dados. A conta de feed de dados da AWS tem permissões de leitura e gravação.


* Se você excluir a assinatura do feed de dados, o Amazon EC2 não removerá as permissões de leitura e gravação para a conta de feed de dados da AWS no bucket, nem nos arquivos de dados. Você precisa remover essas permissões por conta própria


## Assinar seu feed de dados da instância spot

Para assinar o feed de dados, use o comando [create-spot-datafeed-subscription](https://docs.aws.amazon.com/cli/latest/reference/ec2/create-spot-datafeed-subscription.html).

~~~sh
aws ec2 create-spot-datafeed-subscription \
    --bucket my-bucket-name \
    [--prefix my-prefix]
~~~

A seguir está um exemplo de saída:

~~~
{
    "SpotDatafeedSubscription": {
        "OwnerId": "111122223333",
        "Bucket": "my-bucket-name",
        "Prefix": "my-prefix",
        "State": "Active"
    }
}
~~~


## Descrever seu feed de dados de instância spot

Para descrever sua assinatura do feed de dados, use o comando [describe-spot-datafeed-subscription](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-spot-datafeed-subscription.html)

`aws ec2 describe-spot-datafeed-subscription`

A seguir está um exemplo de saída:

~~~
{
    "SpotDatafeedSubscription": {
        "OwnerId": "123456789012",
        "Prefix": "spotdata",
        "Bucket": "my-s3-bucket",
        "State": "Active"
    }
}
~~~



## Excluir seu feed de dados de instância spot

Para excluir o feed de dados, use o comando [delete-spot-datafeed-subscription](https://docs.aws.amazon.com/cli/latest/reference/ec2/delete-spot-datafeed-subscription.html)


`aws ec2 delete-spot-datafeed-subscription`