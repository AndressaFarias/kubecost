# kubecost

## Instalação - AWS
Segue a sequencia de instalação dos componentes do kubecost

### **1 Instalar o kubecost nos clusters**

   Executar o comando abaixo utilizando o helm 3

   ~~~sh
      helm install kubecost kubecost/cost-analyzer --namespace kubecost \
      --set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
      --set global.prometheus.enabled="false" \
      --set global.prometheus.fqdn="http://prometheus-kube-prometheus-prometheus.monitoring.svc:9090" \
      --set global.grafana.domainName="grafana.loggi.com" \
      --set global.grafana.enabled="false" \
      --set global.alertmanager.enabled="true" \
      --set kubecostProductConfigs.grafanaURL="grafana.loggi.com" \
      --set prometheus.kube-state-metrics.disabled="true" \
      --set prometheus.server.persistentVolume.enabled="false" \
      --set prometheus.nodeExporter.enabled="false" \
      --set prometheus.serviceAccounts.nodeExporter.create="false" \
      --set prometheus.alertmanager.persistentVolume.enabled="false" \
      --set serviceMonitor.enabled="true" \
      --version 1.93.1
   ~~~
   
### **2 Executar o Terraform das pasta `cur` na workspace `root-account`** 

Esse terraform cria o bucket que armazena os relatórios _Cost and Usage Report_ (cur) e o próprio relatório. 
      
Para a execução dos próximos passos é preciso que o arquivo `crawler-cfn.yml` já esteja disponivel. Esse arquivo é gerado automaticamente no momento em que o primeiro _cur_ criado, a geração do _cur_ leva de 12 horas a 24 horas.


### **3. Executar o terraform da pasta `cfn` na workspace `root-account`**
Esse terraform executa o template _cloud formation_ gerado no bucket do passo anterior. Também é criado o bucket que irá salvar as consultas feitas no Athena.


📌 **NOTA 1**
> **O output desse Terraform irá conter o nome do bucket que irá reter as consultas feitas no Athena.** 
Essa informação está contida da saída: `aws-athena-query-results_bucket_query-result-location`.
Navigue até https://console.aws.amazon.com/athena
Clique em _Settings_ em seguida em _Manage_ No campo _Location of query result_ insira o nome do bucket obtido no output.




