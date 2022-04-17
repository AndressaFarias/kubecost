https://github.com/kubecost/docs/blob/master/cloud-integration.md

# Cloud Integrations
A integração com os provedores de serviços em nuvem por meio de suas respectivas APIs de cobrança permitem que o Kubecost exiba os custos fora do cluster, que são os custos incorridos em uma conta de cobrança de Serviços fora do(s) cluster(s) onde o Kubecost está instalado, além da capacidade de reconciliar as previsões do Kubecosts no cluster com os dados de faturamento reais para melhorar a precisão. Para obter mais detalhes sobre essas integrações, continue lendo abaixo. Para obter guias sobre como configurar essas integrações, siga o link relevante:
* Multi-Cloud
* AWS  :: https://github.com/kubecost/docs/blob/master/aws-cloud-integrations.md 
* GCP
* Azure

## Cloud Processes
Conforme indicado acima, configurar uma integração na nuvem com seu provedor de serviços em nuvem permite que o Kubecost obtenha dados de cobrança adicionais. Os dois processos que incorporam essas informações são Reconciliation (Reconciliação) e Cloud Assets.

### Reconciliation
A reconciliação corresponde a "\Assets" no cluster com itens encontrados nos dados de cobrança extraídos do Cloud Service Provider. Isso permite que o Kubecost exiba a representação mais precisa de seus gastos no cluster. Além disso, o processo de reconciliação cria "\assets" de rede para nós no cluster com base nas informações nos dados de cobrança. A principal desvantagem desse processo é que os provedores de serviços em nuvem têm um atraso de 6 a 24 horas na liberação dos dados de cobrança, e a reconciliação requer um dia inteiro de dados de custo para reconciliar com os ativos do cluster. Isso requer uma janela de 48 horas entre o uso de recursos e a reconciliação. Se a reconciliação for realizada nesta janela, o custo do ativo será deflacionado para o custo parcialmente completo mostrado nos dados de faturamento.

### Cloud Assets
O processo "\Cloud Assets" permite que o Kubecost extraia gastos de nuvem fora do cluster dos dados de cobrança do seu provedor de serviços de nuvem. Isso inclui todos os serviços executados pelo provedor de serviços de nuvem, além de recursos de computação fora dos clusters monitorados pelo Kubecost. Além disso, ao rotular esses ativos de nuvem, seu custo pode ser distribuído para alocações como custos externos. Isso pode ajudar as equipes a entender melhor a proporção de gastos na nuvem fora do cluster da qual seu uso no cluster depende. Os Cloud Assets ficam disponíveis assim que aparecem nos dados de faturamento, com o atraso de 6 a 24 horas mencionado acima, e são atualizados à medida que ficam mais completos.

## Cloud Integration Configurations
O "\helm chart" do Kubecost fornece valores que podem habilitar ou desabilitar cada processo de nuvem no "\deployment" após a configuração de uma integração de nuvem. A desativação de qualquer um desses processos desativará todos os benefícios fornecidos por eles.

## Cloud Stores
O ETL contém um Mapa de Cloud Stores, cada um representando uma integração com um Cloud Service Provider. Cada Cloud Store é responsável pelos Cloud Asset e Reconciliation Pipelines que adicionam custos Out-of-Cluster e ajustam o custo estimado do Kubecost, respectivamente, por meio de dados de custo e uso extraídos do Cloud Service Provider. Cada Cloud Store tem um identificador exclusivo chamado ProviderKey, que varia dependendo de qual provedor de serviços de nuvem está sendo conectado e garante que configurações duplicadas não sejam introduzidas no ETL. O valor do `ProviderKey` é o seguinte para cada provedor de serviços de nuvem em um escopo para o qual os dados de cobrança estão sendo:
* AWS: Account Id
* GCP: Project Id
* Azure: Subscription Id

O `ProviderKey` pode ser usado como argumento para os endpoints para Cloud Assets and Reconciliation, para indicar que a operação especificada deve ser feita apenas em um único Cloud Store, e não em todos eles, que é o comportamento padrão. Além disso, o Cloud Store acompanha o status do diagnóstico de conexão de nuvem para cada um dos ativos de nuvem e reconciliação. O Status da Conexão na Nuvem deve ser usado como uma ferramenta para determinar a integridade da Conexão na Nuvem que é a base de cada Armazenamento na Nuvem. O Status da Conexão na Nuvem tem vários estados de falha que se destinam a fornecer informações acionáveis sobre como fazer com que sua Conexão na Nuvem funcione corretamente. Estes são os status de conexão com a nuvem:

* INITIAL_STATUS é o valor zero do Cloud Connection Status e significa que a conexão na nuvem não foi testada. Uma vez que o Cloud Connection Status foi alterado e não deve retornar a este valor. Este status é atribuído na criação ao Cloud Store;

* MISSING_CONFIGURATION significa que o Kubecost não detectou nenhum método de configuração de nuvem. Esse valor só é possível no primeiro Cloud Store criado como wrapper para o provedor de nuvem de software livre. Esse status é atribuído durante falhas na recuperação de configuração.

* INCOMPLETE_CONFIGURATION significa que a Cloud Configuration não tem os valores necessários para se conectar ao provedor de nuvem. Esse status é atribuído durante falhas na recuperação de configuração.

* FAILED_CONNECTION: significa que todos os valores necessários de Cloud Configuration estão preenchidos, mas não é possível estabelecer uma conexão com o Provedor de Nuvem. Isso é indicativo de um erro de digitação em um dos valores de configuração do Cloud ou de um problema em como a conexão foi configurada no Console do provedor de nuvem. A atribuição desse status varia entre os Provedores, mas deve ocorrer se houver um erro quando ocorrer uma interação com um objeto do SDK do Cloud Service Provider.

* MISSING_DATA: significa que o Cloud Integration está configurado corretamente, mas o provedor de nuvem não está retornando dados de faturamento/custo e uso. Esse status é indicativo de que a exportação de dados de cobrança/custo e uso do provedor de nuvem foi configurada incorretamente ou a exportação foi configurada nas últimas 48 horas e ainda não começou a preencher os dados. Este status é definido quando uma consulta foi feita com sucesso, mas os resultados voltam vazios. Se o provedor de nuvem já possui o status SUCCESSFUL_CONNECTION, esse status não deve ser definido, pois indica que a consulta específica realizada pode estar vazia.

* SUCCESSFUL_CONNECTION: significa que o Cloud Integration está configurado corretamente e retornando dados. Este status é definido em qualquer consulta bem-sucedida em que os dados são retornados

Após iniciar ou reiniciar o Cloud Assets ou Reconciliation, dois subprocessos são iniciados, um que preenche os dados históricos sobre a cobertura do Daily Asset Store e outro que é executado periodicamente, em um intervalo predefinido, para coletar e processar novos dados de custo e uso conforme são disponibilizados pelo Cloud Service Provider. O endpoint de status do ETL contém um o cloud object que fornece informações sobre cada armazenamento em nuvem, incluindo o status de conexão com a nuvem e informações de diagnóstico sobre ativos de nuvem e reconciliação. Os itens de diagnóstico no Cloud Assets and Reconciliation são:

* Coverage (Cobertura): A janela de tempo que o subprocesso histórico cobriu;

* LastRun: A última vez que o processo foi executado, é atualizado sempre que o subprocesso periódico é executado 

* NextRun: Próxima execução agendada do subprocesso periódico 

* Progress: Proporção de cobertura para o tempo total a ser coberto 

* RefreshRate: o intervalo que o subprocesso periódico executa

* Resolution: o tamanho dos ativos que estão sendo recuperados 

* StartTime: quando o processo de nuvem foi iniciado

## EndPoints
`http://<kubecost-address>/model/etl/asset/cloud/rebuild`

Descrição:

Reinicie completamente o Cloud Asset Pipeline. Essa operação encerra o Cloud Asset Pipeline atualmente em execução e reconstrói Cloud Assets históricos no Daily Asset Store.

Exemplo de usos:

`http://localhost:9090/model/etl/asset/cloud/rebuild` 
// isso não será executado porque está faltando o parâmetro commit

`http://localhost:9090/model/etl/asset/cloud/rebuild?commit=true`

`http://localhost:9090/model/etl/asset/cloud/rebuild?commit=true&provider=######-######-######`

Os parâmetros da API incluem o seguinte:

* `commit` é uma flag booleano que atua como uma precaução de segurança, esses podem ser processos de longa execução, portanto, esse endpoint não deve ser executado arbitrariamente. um valor `true`reinicia o processo. 

* `proveder` é um parâmetro opcional que recebe a Chave do Provedor descrita acima. Se incluído, apenas o Cloud Store especificado executará a operação, se não estiver incluído, todos os Cloud Stores no ETL executarão a operação.


____________________

`http://<kubecost-address>/model/etl/asset/cloud/repair`

Descrição:

Reexecuta as consultas para Cloud Assets na janela especificada para o Cloud Store determinado ou todos os Cloud Stores se nenhum provedor estiver definido.

Exemplo de usos:

`http://localhost:9090/model/etl/asset/cloud/repair`

`http://localhost:9090/model/etl/asset/cloud/repair?window=7d`

`http://localhost:9090/model/etl/asset/cloud/repair?window=yesterday&provider=######-######-######`

Os parâmetros da API incluem o seguinte:

* `window` determina a janela aplicável para reparo pela Cloud Store. Opções de suporte atuais: "15m", "24h", "7d", "48h", etc. "today", "yesterday", "week", "month", "lastweek", "lastmonth" "1586822400,1586908800" , etc. (início e fim de timestamps unix) "2020-04-01T00:00:00Z,2020-04-03T00:00:00Z", etc. (início e fim de pares UTC RFC3339)


* `provedor` um parâmetro opcional que recebe a `ProviderKey` descrita acima. Se incluído, apenas o Cloud Store especificado executará a operação, se não estiver incluído, todos os Cloud Stores no ETL executarão a operação.


____________________

`http://<kubecost-address>/model/etl/asset/reconciliation/rerun`

Descrição:

Reinicie completamente o Pipeline de reconciliação. Essa operação encerra o Pipeline de reconciliação atualmente em execução e reconcilia os Ativos históricos no Daily Asset Store.

Exemplo de usos:

`http://localhost:9090/model/etl/asset/reconciliation/rerun` // isso não será executado porque está faltando o parâmetro commit

`http://localhost:9090/model/etl/asset/reconciliation/rerun?commit=true`

`http://localhost:9090/model/etl/asset/cloud/reconciliation/rerun?commit=true&provider=######-######-######`


Os parâmetros da API incluem o seguinte:

* `commit` é uma flag booleana que atua como uma precaução de segurança, esses podem ser processos de longa execução, portanto, esse ponto de extremidade não deve ser executado arbitrariamente. um valor verdadeiro reinicia o processo.

* `proveder` um parâmetro opcional que recebe a `ProviderKey` descrita acima. Se incluído, apenas o Cloud Store especificado executará a operação, se não estiver incluído, todos os Cloud Stores no ETL executarão a operação.

____________________

`http://<kubecost-address>/model/etl/asset/reconciliation/repair`

Descrição:

Reexecuta as consultas para reconciliação na janela especificada para o Cloud Store determinado ou todos os Cloud Stores se nenhum provedor estiver definido.

Exemplo de usos:

`http://localhost:9090/model/etl/asset/reconciliation/repair`

`http://localhost:9090/model/etl/asset/reconciliation/repair?window=7d`

`http://localhost:9090/model/etl/asset/reconciliation/repair?window=yesterday&provider=######-######-######`

* `window` determina a janela aplicável para reparo pela Cloud Store. Opções de suporte atuais: "15m", "24h", "7d", "48h", etc. "today", "yesterday", "week", "month", "lastweek", "lastmonth" "1586822400,1586908800" , etc. (início e fim de timestamps unix) "2020-04-01T00:00:00Z,2020-04-03T00:00:00Z", etc. (início e fim de pares UTC RFC3339)


* `provedor` um parâmetro opcional que recebe a `ProviderKey` descrita acima. Se incluído, apenas o Cloud Store especificado executará a operação, se não estiver incluído, todos os Cloud Stores no ETL executarão a operação.

____________________

`http://<kubecost-address>/model/etl/status`

Descrição

Retorna um objeto de status para o ETL. Isso inclui seções para `allocation`, `assets` e `cloud`.

Exemplo de usos:

`http://localhost:9090/model/etl/status`