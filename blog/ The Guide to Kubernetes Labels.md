Kubecost é uma ferramenta de monitoramento e gerenciamento de custos para Kubernetes. Ajudamos nossos usuários a rastrear e economizar bilhões de dólares em gastos. O Kubecost é executado em qualquer lugar que o K8s seja executado; instale hoje!


# [The Guide to Kubernetes Labels](https://blog.kubecost.com/blog/kubernetes-labels/)


O uso de tags de metadados anexadas a diferentes recursos e objetos é um requisito obrigatório para qualquer ambiente Kubernetes (K8s). Os labels do Kubernetes permitem que as equipes de DevOps realizem pesquisas de objetos no cluster, apliquem alterações de configuração em massa e muito mais. Os rótulos podem ajudar a simplificar e resolver muitos desafios diários encontrados em ambientes Kubernetes:

Challenge - Description
------------------------
Troubleshooting - A CPU de um pod é fixada em 100%. Seu rótulo ajuda a determinar rapidamente se ele oferece suporte a um ambiente de teste ou de produção.

Configuration - Você deseja aplicar um patch, mas apenas a uma dúzia de contêineres que suportam o front-end do seu aplicativo. Você usa labels para isolar esses contêineres.

Monitoramento, alocação e gerenciamento de custos - Alguns locatários compartilham um cluster e você deseja gerar um relatório de alocação de custos. Você usa o Kubecost para gerar o relatório e agrupar os dados pelo rótulo relevante.

Neste artigo, você aprenderá sobre:

* Tagging Methods
* Use Cases for Kubernetes Labels
* Labeling Best Practices
* What You Should NOT Do With Kubernetes Labels

## Tagging Methods (_Métodos de marcação_)
Para ajudar a organizar os recursos do cluster, o Kubernetes oferece duas maneiras de marcar metadados para objetos:

### 1.Via Labels

Labels são pares de chave-valores usados ​​para anexar metadados de identificação a objetos do Kubernetes. O Kubernetes fornece suporte integrado para consultar objetos por meio de rótulos e aplicar operações em massa no subconjunto selecionado.
As labelss do Kubernetes são comumente usadas ​​para compartilhar informações com outros colegas. Por exemplo, você pode usar um rótulo para registrar um identificador de proprietário para a pessoa responsável por um pod/deployment. As etiquetas ficam assim:

~~~yaml
"metadata": {
  "labels": {
    "key1" : "value1",
    "key2" : "value2",
    "key3" : "value3"
  }
}
~~~

### 2.Via Annotations
Esses são pares de chave-valor usados ​​para anexar metadados não identificadores a objetos. No entanto, ao contrário das labels, as annotations geralmente não são destinadas a consultar ou aplicar operações a um subconjunto de objetos do Kubernetes. As anotações ficam assim:
~~~yaml
"metadata": {
   "annotations": {
     "key1" : "value1",
     "key2" : "value2",
     "key3" : "value3"
      }
 }
~~~

## Use Cases for Kubernetes Labels (Casos de uso para rótulos do Kubernetes)

Existem dois usos principais para rótulos em um ambiente Kubernetes:


### 1. Grouping Resources for Queries (_Agrupando recursos para consultas_)

Ao anexar labels consistentes em diferentes objetos, você pode pesquisar rapidamente esses objetos no Kubernetes usando consultas simples ou avançadas. Por exemplo, suponha que você receba uma ligação de seus desenvolvedores perguntando se o ambiente de desenvolvimento está inativo. Se os pods dev tiverem um rótulo “dev”, você poderá executar o seguinte comando kubectl para obter seu status:

~~~yaml
    kubectl get pods -l 'environment in (dev)’ 
    NAME  READY STATUS  RESTARTS  AGE
    cert-manager-6588898cb4-25n79   0/1   ErrImagePull   0   3d2h
~~~

Neste exemplo, você pode identificar que um dos pods de desenvolvimento tem um problema ao extrair uma imagem e fornecer essas informações aos desenvolvedores que usam o pod dev. Se você não tivesse rótulos, teria que grep manualmente a saída de kubectl get pods com base em alguma outra convenção não estruturada.

### 2. Bulk Operations (_2. Operações em massa_)

Além das consultas, o Kubernetes também permite operações em massa usando labels selectors. Por exemplo, se você excluir todos os seus ambientes de desenvolvimento/staging à noite para economizar nos custos de computação, poderá automatizar o seguinte comando:

`kubectl delete deployment,services,statefulsets -l environment in (dev,sit)`

Este comando executa kubectl delete em todos os objetos retornados que possuem os rótulos `environment`: `dev` ou `environment`: `sit`.


## Labeling Best Practices - (_Práticas recomendadas de rotulagem_)

Siga estas oito recomendações essenciais de práticas recomendadas para evitar erros comuns de rotulagem:


### **1. Learn the Syntax Properly (_1. Aprenda a sintaxe corretamente_)**

Os rótulos do Kubernetes usam uma estrutura de par chave-valor. Aqui está o que você precisa saber.

**Keys**

As chaves podem ter dois segmentos: um prefixo e um nome separados por uma barra, por exemplo, "<prefix>/<name>".

* **Prefix** :  Opcional; deve ser um subdomínio DNS válido (por exemplo,`empresa.com/<nome>`).

* **Name** : suporta até 63 caracteres, incluindo incluindo: caracteres alfanuméricos, traços, sublinhados e pontos.

O prefixo é útil para módulos que não são privados para o usuário, como kube-scheduler, kubectl, etc. Se você estiver instalando módulos externos usando helm, as chaves de seus rótulos provavelmente terão prefixos anexados. O prefixo também permite o uso de vários rótulos que podem entrar em conflito entre si. Por exemplo, o gatekeeper é um aplicador da política Customer Resource Definition (CRD) que pode ser instalado como um gráfico usando o leme, e seus rótulos são prefixados com `gatekeeper.sh`

O nome (no exemplo empresa.com/<nome>) contém o nome da propriedade arbitrária da labels. Por exemplo, você pode usar company.com/environment para designar o tipo de ambiente. Os valores de rótulo correspondentes podem ser "produção", "teste" e "desenvolvimento". Você pode pular o prefixo company.com se não pretender distribuir seus recursos fora de sua empresa (desde que não espere um conflito de nomenclatura com outro pacote de terceiros instalado em seu ambiente usando o mesmo rótulo sem um prefixo).


**Values**

* Deve ter no máximo 63 caracteres
* Suporta alfanumérico com traços, sublinhados e pontos
* Deve começar e terminar com caracteres alfanuméricos (a menos que esteja vazio)


### **2. Know the Label Selection Methods - (_2. Conheça os métodos de seleção de rótulos_)**

O Kubernetes fornece duas maneiras de selecionar objetos com labels: seletores de igualdade e baseados em conjunto (equality and set-based selectors.).

* **Equality** :  Você pode selecionar objetos que são iguais ou não iguais a um ou mais valores de labels. Você pode ter vários seletores separados por vírgulas e todas as condições devem ser atendidas para que um recurso corresponda a esse seletor. Como parte desta sintaxe, `=` e `==` significam igualdade, enquanto `!=` significa desigualdade. Por exemplo, você pode selecionar `"environment=dev,release=nightly"` para obter os recursos que têm os dois rótulos anexados;

* **Set** : Permite a seleção de acordo com vários valores. Um conjunto é semelhante à palavra-chave `IN` no SQL. Por exemplo, `"environment in (dev,uat)"` selecionará os recursos rotulados dev e uat. Os operadores suportados são `“in”`, `“notin”` e `“exists”`                                                           .


### **3.Use Recommended Labels (_Use rótulos recomendados_)
O Kubernetes fornece uma lista de rótulos recomendados que permitem um agrupamento de básico de objetos de recursos. O prefixo `app.kubernetes.io` distingue entre os rótulos recomendados pelo Kubernetes e os rótulos personalizados que você pode adicionar separadamente usando um prefixo company.com. Alguns dos rótulos recomendados mais populares do Kubernetes estão listados abaixo.

`app.kubernetes.io/name`: Nome do aplicativo (por exemplo, redis)

`app.kubernetes.io/instance`: Nome exclusivo para esta instância específica do aplicativo (por exemplo, redis-department-a)

`app.kubernetes.io/component` : Um identificador descritivo da finalidade do componente (por exemplo, cache de login).

`app.kubernetes.io/part-of`: O aplicativo de nível superior que usa esse recurso (por exemplo, company-auth)


### **4.Create Organization-Wide Label Naming Conventions - (_Crie convenções de nomenclatura de rótulos em toda a organização_)

É importante ter convenções de rótulo que sejam seguidas estritamente em toda a organização.Todas as equipes que usam recursos do Kubernetes devem seguir as mesmas convenções de nomenclatura claramente definidas. Seu pipeline de compilação também deve verificar os arquivos de configuração para garantir que todos os rótulos necessários estejam anexados.

Por exemplo, digamos que você esteja desenvolvendo um aplicativo com front-end, back-end, banco de dados Postgres e cache Redis. As equipes responsáveis ​​por cada uma dessas camadas devem seguir as mesmas convenções para rótulos do Kubernetes. Se a convenção para ambientes for rotular com a chave “app-environment”, todas as camadas devem ter a mesma chave para o ambiente do aplicativo. As ferramentas de monitoramento geralmente contam com rótulos para filtrar os componentes desejados que dão suporte a um ambiente de produção.  Essa abordagem evita gerar alertas de monitoramento de componentes do Kubernetes associados ao ambiente de teste que distrairiam as equipes de operações.


### **5.Include Required Labels in Pod Templates - (_5. Incluir rótulos obrigatórios em modelos de pod_)

Selecione um subconjunto de labels que você considera obrigatórios e adicione-os ao pod template. Os controllers do Kubernetes usam pod template como manifestos para criar um pod com especificações para o estado desejado. Os pod templates estão inclusos em recursos de workload, como Deployments e DaemonSets. Você pode começar com um pequeno subconjunto de rótulos. Por exemplo, você pode começar exigindo apenas três rótulos em seu modelo: environment (produto, teste), versão (GA, beta) e proprietário.


### **6.Label Extensively - (_6. Rotule extensivamente_)
Rotule objetos o máximo possível para manter a visibilidade em toda a sua infraestrutura. Suponha que você precise depurar rapidamente um problema ou ver qual processo está sobrecarregando seus recursos de infraestrutura. Nesse cenário, a rotulagem extensiva facilitará o detalhamento dos recursos do Kubernetes com precisão.


### **7. Label Cross-Cutting Concerns - (_7. Rotular Preocupações Transversais_)
Esta melhor prática anda de mãos dadas com a anterior. Você deve fazer bom uso dos rótulos para marcar as preocupações transversais, pois os rótulos devem conter metadados transversais.
Você pode estabelecer convenções em sua organização para atender às suas necessidades. Aqui estão algumas recomendações para você começar:

* Environment como dev, staging, produção;

* Um nível de serviço diferente (_A different tier of service_), como nível gratuito, nível profissional;

* Release channels como noturno, estável, beta

* Um tenant específico em uma situação de vários tenants, como `departamento_a`, `departamento_b`

* Contatos de suporte (por exemplo, "support": "database_team_ext_1120")



### **8. Automate Labeling - (_8. Rotulagem Automatizada_)

Você também pode automatizar alguns dos rótulos para preocupações transversais usando suas ferramentas de CI/CD (integração contínua e entrega contínua). Por exemplo, se você tiver pipelines de CD de release separados para dev/staging/production, poderá anexar labels de estagágio de release e labels de versão semântica automaticamente usando suas ferramentas de CD. Essa abordagem também pode garantir que haja menos dependência dos desenvolvedores para rotular tudo bem.

**Cheat Sheet**
[...]


## How NOT to Use Kubernetes Labels - (_Como NÃO usar rótulos do Kubernetes_)
Embora os labels sejam ótimos, há algumas coisas que você NÃO deve fazer com eles. Aqui estão três coisas que você deve evitar ao trabalhar com rótulos do Kubernetes:

1. **Não armazene dados alterados com frequência ou altere rótulos sem um bom motivo em um recurso em execução.** Os rótulos são mutáveis, mas isso não significa que eles devam armazenar informações de identificação que mudam com frequência. Por exemplo, talvez você não queira armazenar o número de linhas em um banco de dados como um rótulo para acompanhar o tamanho do banco de dados, a menos que o esteja atualizando apenas em um tempo fixo.

2. **Não armazene semântica em nível de aplicativo no sistema.** Espera-se que as labels do Kubernetes identifiquem e anexem os objetos de recurso com metadados, mas não se destinam a ser um armazenamento de dados para os aplicativos subjacentes. Os recursos do Kubernetes são transitórios e apenas fracamente acoplados ao aplicativo, tornando os rótulos obsoletos ao longo do tempo.

3. **Não fique solto com convenções de nomenclatura.** Conforme mencionado na seção de melhores práticas de rótulos, não ter convenções de rotulagem rígidas pode ser prejudicial. Por exemplo, suponha que você esteja pressionado no tempo para consultar (ou operar) alguns objetos de recurso e, de repente, perceber que seu cluster tem vários rótulos para a mesma camada. Nessa situação, você provavelmente falhará em seus requisitos de SLA quando identificar o rótulo correto.



# Final Thoughts - (_Pensamentos finais_)

Os rótulos são uma parte integrada essencial do Kubernetes e podem fornecer o equivalente a um bisturi para realizar operações poderosas (como obter visibilidade completa dos gastos do Kubernetes usando o Kubecost) em seu cluster com precisão. Use-os consistentemente e eles economizarão muito tempo!

