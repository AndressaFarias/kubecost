# Step 3: Setting up IAM permissions
(_Etapa 3: configurar permissões do IAM_)

## Add via CloudFormation:
(_Adicionar via CloudFormation_)

## Add manually
(_Adicionar manualmente_)


### My Kubernetes clusters run in the same account as the master payer account
(_Meus clusters Kubernetes são executados na mesma conta que a conta pagadora mestre_)

### My Kubernetes clusters run in different accounts
(_Meus clusters do kubernetes são executados em contas diferentes da conta do pagador mestre_)

Em cada subconta executando o kubecost, anexe as duas políticas a seguir à mesma role ou user. Use um usuário se você pretende integrar via servicekey e uma função se for via anotação do IAM (Veja mais abaixo em Via Pod Annotation by EKS). 