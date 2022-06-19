# Cost Report

Os relatórios do Kubecost contêm informações detalhadas sobre a distribuição de custos do cluster. Assim como na visualização de alocação de custos, você pode gerar esses relatórios com base em namespaces, objetos do Kubernetes ou rótulos. Você pode adicionar filtros e criar relatórios específicos para um determinado tenant ou team. Ele também fornece funcionalidade de exportação, o que ajuda a compartilhar isso com as equipes em intervalos regulares, resultando em maior visibilidade. [1]

# Out of cluster cost

É uma extensão da integração do Kubecost com relatórios de custos do provedor de nuvem. Many times we use a lot of cloud provider managed services with Kubernetes like RDS, MSK, etc. O recurso de custo fora do cluster ajuda você a aprimorar seus relatórios de custos do Kubernetes com esses custos, resultando no uso do Kubecost como uma solução completa de relatórios de custos da stack. A maneira como ela correlaciona sua tag é totalmente baseada na marcação de recursos. Assim, por exemplo, você pode usar um identificador de namespace e marcar seus recursos de nuvem adequadamente. [1]



# Referencia
1 - Kubernetes Cost Reporting using Kubecost :: https://www.infracloud.io/blogs/kubernetes-cost-reporting-using-kubecost/