helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set prometheus.fqdn=http://prometheus-kube-prometheus-prometheus.monitoring.svc \
--set global.grafana.enabled="false" \
--set kubecostProductConfigs.grafanaURL="grafana.loggi.com" 
--set prometheus.kube-state-metrics.disabled="true" \
--set prometheus.server.persistentVolume.enabled="false" \
--set prometheus.nodeExporter.enabled="false" \
--set prometheus.serviceAccounts.nodeExporter.create="false" \
--set prometheus.alertmanager.persistentVolume.enabled="false" \
--set serviceMonitor.enabled="true" \
--version 1.93.1 

>> cost-analyzer ficou dando erro 

helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set prometheus.fqdn=http://prometheus-kube-prometheus-prometheus.monitoring.svc \
--set global.grafana.enabled="false" \
--set kubecostProductConfigs.grafanaURL="grafana.loggi.com" \
--set prometheus.kube-state-metrics.disabled="true" \
--set prometheus.server.persistentVolume.enabled="false" \
--set prometheus.nodeExporter.enabled="false" \
--set prometheus.serviceAccounts.nodeExporter.create="false" \
--set prometheus.alertmanager.persistentVolume.enabled="false" \
--set serviceMonitor.enabled="true" \
--version 1.93.1

>> ficou dando erro apontando para o endereço do prometheus errado http://cost-analyzer-prometheus-server.default.

helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set prometheus.fqdn="http://prometheus-kube-prometheus-prometheus.monitoring.svc" \
--set global.grafana.enabled="false" \
--set kubecostProductConfigs.grafanaURL="grafana.loggi.com" \
--set prometheus.kube-state-metrics.disabled="true" \
--set prometheus.server.persistentVolume.enabled="false" \
--set prometheus.nodeExporter.enabled="false" \
--set prometheus.serviceAccounts.nodeExporter.create="false" \
--set prometheus.alertmanager.persistentVolume.enabled="false" \
--set serviceMonitor.enabled="true" \
--version 1.93.1


>> pod instavels


helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set global.prometheus.fqdn="prometheus-kube-prometheus-prometheus.monitoring.svc" \
--set global.grafana.enabled="false" \
--set kubecostProductConfigs.grafanaURL="grafana.loggi.com" \
--set prometheus.kube-state-metrics.disabled="true" \
--set prometheus.server.persistentVolume.enabled="false" \
--set prometheus.nodeExporter.enabled="false" \
--set prometheus.serviceAccounts.nodeExporter.create="false" \
--set prometheus.alertmanager.persistentVolume.enabled="false" \
--set serviceMonitor.enabled="true" \
--version 1.93.1






helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set global.prometheus.fqdn="prometheus-kube-prometheus-prometheus.monitoring.svc" \
--set kubecostProductConfigs.grafanaURL="grafana.loggi.com" \
--set prometheus.kube-state-metrics.disabled="true" \
--set prometheus.server.persistentVolume.enabled="false" \
--set prometheus.nodeExporter.enabled="false" \
--set prometheus.serviceAccounts.nodeExporter.create="false" \
--set prometheus.alertmanager.persistentVolume.enabled="false" \
--set serviceMonitor.enabled="true" \
--version 1.93.1



>>




helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set global.prometheus.fqdn="prometheus-kube-prometheus-prometheus.monitoring.svc:9090" \
--set global.domainName="grafana.loggi.com" \
--set prometheus.kube-state-metrics.disabled="true" \
--set prometheus.nodeExporter.enabled="false" \
--set prometheus.serviceAccounts.nodeExporter.create="false" \
--set serviceMonitor.enabled="true" \
--version 1.93.1




>>





helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set global.prometheus.fqdn="prometheus-kube-prometheus-prometheus.monitoring.svc:9090" \
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



>>

helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.prometheus.enabled="false" \
--set global.prometheus.fqdn="prometheus-kube-prometheus-prometheus.monitoring.svc:9090" \
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


>> falha no prometheus
image.png


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

--- 
Parameter: 
Description:                                   
Default: 
---

global.prometheus.enabled
Se false, use uma instalação existente do Prometheus.
true
---
--set prometheus.fqdn=http://<prometheus-server-service-name>.<prometheus-server-namespace>.svc
---

prometheus.kube-state-metrics.disabled
Se for false, implante kube-state-metrics para métricas do Kubernetes
false
---

prometheus.server.persistentVolume.enabled
Se true, o servidor Prometheus criará um Persistent Volume Claim.
true
---
prometheus.nodeExporter.enabled 
prometheus.serviceAccounts.nodeExporter.create
Se false, não crie o daemonset NodeExporter.
true
---
prometheus.alertmanager.persistentVolume.enabled
Se true, o Alertmanager criará um Persistent Volume Claim.
true
---
prometheus.pushgateway.persistentVolume.enabled
Se true, o Prometheus Pushgateway criará uma Persistent Volume Claim.
true

---
serviceMonitor.enabled
Defina isso como true para criar o operador ServiceMonitor for Prometheus


>> data-stg

helm install kubecost kubecost/cost-analyzer --namespace kubecost \
--set kubecostToken="YW5kcmVzc2EuZmFyaWFzQGxvZ2dpLmNvbQ==xm343yadf98" \
--set global.grafana.domainName="grafana.loggi.com" \
--set global.grafana.enabled="false" \
--set global.alertmanager.enabled="true" \
--set kubecostProductConfigs.grafanaURL="grafana.loggi.com" \
--version 1.93.1


