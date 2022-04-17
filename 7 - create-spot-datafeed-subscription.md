>> desdobramento da etapa 3

# create-spot-datafeed-subscription

## Descrição
Cria um feed de dados para instâncias spot, permitindo que você visualize os logs de uso de instâncias spot. Você pode criar um feed de dados por conta da Amazon Web Services. Para obter mais informações, consulte o [feed de dados da instância spot](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/spot-data-feeds.html) no Guia do usuário do Amazon EC2 para instâncias do Linux


📙 Consulte também: [Documentação da API da AWS](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/APIReference/API_CreateSpotDatafeedSubscription.html)

📙 Consulte '[aws help](https://docs.aws.amazon.com/cli/latest/reference/index.html)' para obter descrições de parâmetros globais.

## Sinopse
~~~sh
  create-spot-datafeed-subscription
--bucket <value>
[--dry-run | --no-dry-run]
[--prefix <value>]
[--cli-input-json <value>]
[--generate-cli-skeleton <value>]
~~~

## Options

* `--bucket` (string)

O nome do bucket do Amazon S3 no qual  armazena o feed de dados da instância spot (_Spot Instance data feed._) . 

* `--dry-run | --no-dry-run` (boolean)

Verifica se você tem as permissões necessárias para a ação, sem realmente fazer a solicitação, e fornece uma resposta de erro. Se você tiver as permissões necessárias, a resposta de erro será DryRunOperation . Caso contrário, é UnauthorizedOperation.

* `--prefix` (string)

O prefixo para os nomes dos arquivos de feed de dados.


* `--cli-input-json` (string)

Executa a operação de serviço com base na string JSON fornecida. A string JSON segue o formato fornecido por `--generate-cli-skeleton`. Se outros argumentos forem fornecidos na linha de comando, os valores da CLI substituirão os valores fornecidos pelo JSON. Não é possível passar valores binários arbitrários usando um valor fornecido por JSON, pois a string será interpretada literalmente.


* `--generate-cli-skeleton` (string)

Imprime um esqueleto JSON na saída padrão sem enviar uma solicitação de API. Se fornecido sem valor ou com a entrada de valor, imprime um JSON de entrada de amostra que pode ser usado como argumento para `--cli-input-json`.  Se fornecido com a saída de valor, ele valida as entradas de comando e retorna um JSON de saída de amostra para esse comando.


## Exemplo

### Para criar um Spot Instance data feed

O exemplo create-spot-datafeed-subscription a seguir cria um _Spot Instance data feed_.

~~~sh
aws ec2 create-spot-datafeed-subscription \
    --bucket my-bucket \
    --prefix spot-data-feed
~~~

Output:

~~~json
{
    "SpotDatafeedSubscription": {
        "Bucket": "my-bucket",
        "OwnerId": "123456789012",
        "Prefix": "spot-data-feed",
        "State": "Active"
    }
}
~~~

O feed de dados é armazenado no bucket do Amazon S3 que você especificou. Os nomes de arquivo para este feed de dados têm o formato a seguir.

`my-bucket.s3.amazonaws.com/spot-data-feed/123456789012.YYYY-MM-DD-HH.n.abcd1234.gz`


## Output

SpotDatafeedSubscription -> (estrutura)

    A assinatura do Spot Instance data feed

    Bucket -> (string)
        O nome do bucket do Amazon S3 em que o feed de dados da instância spot está localizado.

    Falha -> (estrutura) (Fault -> (structure))

        Os códigos de falha para a solicitação de instância spot, se houver.

        Code -> (string)
            O código de razão para a mudança de estado da instância spot.

        Message -> (string)
            A mensagem para a mudança de estado da instância spot.

    OwnerId -> (string)
        O ID da conta da Amazon Web Services da conta.

    Prefix -> (string)
        O prefixo dos arquivos de feed de dados.


    State -> (string)
        O estado da assinatura do feed de dados da instância spot.

    





