# Retorno de pesquisa por recurso retorna como `__unallocated__`

![unallocated resource](unallocated.png)

Referencia:
[Kubernetes Cost Allocation](https://guide.kubecost.com/hc/en-us/articles/4407601807383-Kubernetes-Cost-Allocation)


ERRO :
host not found in upstream "cost-analyzer-grafana.default.svc" in /etc/nginx/conf.d/default.conf:45




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
      --set kubecostProductConfigs.clusterName="<NameCluster>"
      --version 1.93.1