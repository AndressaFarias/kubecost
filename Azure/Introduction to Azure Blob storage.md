# Introduction to Azure Blob storage
[About Blob storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)


O armazenamento de Blobs do Azure é a solução de armazenamento de objetos da Microsoft para a nuvem. O armazenamento de blobs é otimizado para armazenar grandes quantidades de dados não estruturados. Dados não estruturados são dados que não aderem a um determinado modelo ou definição de dados, como texto ou dados binários.


## About Blob storage (Sobre o armazenamento de blobs)

O armazenamento de blobs foi projetado para:

* Servindo imagens ou documentos diretamente para um navegador. 
* Armazenando arquivos para acesso distribuído. 
* Transmissão de vídeo e áudio. 
* Gravando em arquivos de log. 
* Armazenar dados para backup e restauração, recuperação de desastres e arquivamento.
* Armazenar dados para análise por um serviço local ou hospedado no Azure.

Os usuários ou aplicativos cliente podem acessar objetos no armazenamento Blob via HTTP/HTTPS, de qualquer lugar do mundo. Os objetos no armazenamento de BLOBs podem ser acessados por meio da API REST do Armazenamento do Azure, Azure PowerShell, CLI do Azure ou uma biblioteca de cliente do Armazenamento do Azure. As bibliotecas de cliente estão disponíveis para diferentes linguagens, incluindo:

 * .NET
 * Java
 * Node.js
 * Python
 * Go
 * PHP*
 * Ruby

## About Azure Data Lake Storage Gen2
[...]

## Blob storage resources (Recursos de armazenamento de blobs)

O armazenamento de blobs oferece três tipos de recursos:
* A storage account;
* Um container na storage account;
* Um blob em um container.

O diagrama a seguir mostra o relacionamento entre esses recursos.

![diagrama relacionamento blob](blob1.png)

### Storage accounts

Uma conta de armazenamento (storage account) fornece um namespace exclusivo no Azure para seus dados. Cada objeto que você armazena no Azure Storage tem um endereço que inclui seu nome de conta exclusivo. A combinação do nome da conta (account name) e do Blob Storage endpoint forma o endereço base para os objetos em sua conta de armazenamento (storage account).


Por exemplo, se sua conta de armazenamento for denominada _mystorageaccount_, o default endpoint para Blob storage será:

`http://mystorageaccount.blob.core.windows.net`

[...]

### Containers

Um contêiner organiza um conjunto de blobs, semelhante a um diretório em um sistema de arquivos. Uma storage account (conta de armazenamento) pode incluir um número ilimitado de contêineres e um contêiner pode armazenar um número ilimitado de blobs.

**NOTE**
> O nome do contêiner deve ser minúsculo. Para obter mais informações sobre a nomenclatura de contêineres, consulte [Naming and Referencing Containers, Blobs, and Metadata](https://docs.microsoft.com/en-us/rest/api/storageservices/Naming-and-Referencing-Containers--Blobs--and-Metadata)



### Blobs
O Armazenamento do Azure dá suporte a três tipos de blobs:

* __Block blobs__ : armazenam texto e dados binários. Block blobs são compostos de blocos de dados que podem ser gerenciados individualmente. Blobs de bloco podem armazenar até cerca de 190,7 TiB.

* __Append blobs__ :  são compostos de blocos como block blobs, mas são otimizados para operações de acréscimo. Os append blobs são ideais para cenários como o registro de dados de máquinas virtuais

* __Page blobs__ : armazene arquivos de acesso aleatório de até 8 TiB de tamanho. Os page blobs armazenam arquivos de disco rígido virtual (VHD) e servem como discos para máquinas virtuais do Azure. [...]



