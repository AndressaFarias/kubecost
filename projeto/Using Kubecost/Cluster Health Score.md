# [Cluster Health Score](https://guide.kubecost.com/hc/en-us/articles/5748367035159-Cluster-Health-Score-)

A pontuação de saúde começa em 100. As penalidades reduzem a pontuação. Existem três tipos de penalidades:

* SevereErrorPenalty = 50
* ErrorPenalty       = 15
* WarningPenalty     = 3

WarningPenalty é aplicado quando:

* Cluster único (o mestre existe no cluster - para implantações de kubernetes baseadas em kops na AWS)
* Região única
* O crescimento de disco preditivo ultrapassa um limite de 90%

ErrorPenalty é aplicado:

* Quaisquer nós no cluster não estão prontos
* Quaisquer nós estão sob MemoryPressure

SevereErrorPenalty é aplicado:

* O uso da memória excede 90% da memória disponível no cluster

## Alert

O alerta de integridade do cluster (Cluster Health) é baseado em um limite de alteração. Por exemplo, um alerta em 14 alertaria sempre que uma penalidade de erro fosse aplicada.
