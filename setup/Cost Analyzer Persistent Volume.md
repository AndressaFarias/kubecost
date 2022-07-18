# [Cost Analyzer Persistent Volume](https://guide.kubecost.com/hc/en-us/articles/4407595981591-Cost-Analyzer-Persistent-Volume)



A partir da v1.67, o volume persistente anexado ao pod primário do Kubecost (analisador de custos) contém dados de cache ETL, bem como dados de configuração do produto. Embora seja tecnicamente opcional, porque todas as configurações podem ser definidas por meio do configmap, ele reduz drasticamente a carga nas instalações do Prometheus/Thanos na reinicialização/reimplantação do pod. Por esse motivo, é fortemente encorajado em clusters maiores.

**Se você estiver criando uma nova instalação do kubecost:**

Recomendamos que você faça backup do Kubecost com pelo menos um disco de 32 GiB. Este é o padrão a partir de 1.72.0.

**Se você estiver atualizando uma versão existente do Kubecost**

* Se o seu provisionador oferecer suporte à expansão de volume, redimensionaremos você automaticamente para um disco de 32 GB na atualização para 1.72.0


## Regional Cluster bindings (_Ligações de cluster regionais_)
Se você estiver usando apenas um PV e ainda tiver problemas com o _rescheduled_ do Kubecost em zonas fora do seu disco, considere usar uma classe de armazenamento com reconhecimento de topologia. Você pode definir a classe de armazenamento do disco Kubecost definindo `persistVolume.storageClass=your-topology-aware-storage-class-name`
