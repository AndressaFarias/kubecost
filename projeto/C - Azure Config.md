# Azure Config

Depois de instalar o Kubecost em uma conta do azure, para acessar dados de cobrança precisos do Microsoft Azure, o Kubecost precisa acessar a API Billing Rate Card.

>  **NOTE** você também pode obter essa funcionalidade mais os custos externos concluindo a integração completa do Kubecost Azure.

Comece criando uma definição de role do Azure. Abaixo está um exemplo de definição, substitua YOURSUBSCRIPTIONID pelo ID da assinatura da sua conta:

~~~jso
{
    "Name": "MyRateCardRole",
    "IsCustom": true,
    "Description": "Rate Card query role",
    "Actions": [
        "Microsoft.Compute/virtualMachines/vmSizes/read",
        "Microsoft.Resources/subscriptions/locations/read",
        "Microsoft.Resources/providers/read",
        "Microsoft.ContainerService/containerServices/read",
        "Microsoft.Commerce/RateCard/read"
    ],
    "AssignableScopes": [
        "/subscriptions/40b9d0de-d1eb-41d6-a51d-aba21458911a"
    ]
}
~~~