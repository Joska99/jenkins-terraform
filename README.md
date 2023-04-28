<h1> Requariments: </h1>

1. [Jnekins Container](https://github.com/Joska99/joska/tree/main/docker/stateful-jenkins)

2. Azure Storage Account for Remote backend

> Create Storage Acount in azure by CLI

- Create variables
```bash
RG_NAME=RG_NAME
SA_NAME=SA_NAME
CONTAINER_NAME=CONTAINER_NAME
```
- Create Storage Acount
```bash
az storage acount create --resource-group $RG_NAME --name $SA_NAME --sku Standard_LRS --encryption-services blob 
```
- Create BLOB Container
```bash
az storage container create --name $CONTAINER_NAME --account-name $SA_NAME 
```
- Get key 
```bash
ACCOUNT_KEY=$(az storage account keys list --resource-group $RG_NAME  --account-name $SA_NAME --query '[0].value' -o tsv)
```

3. Service Principal with Contributor RBAC on Subscrription

- In Azuer Portal CLI create Service Principal for Jenkins:

> Create variables
``` Bash
SP_NAME=SERVICE_PRINCIPAL_NAME
```
> Create service principal
```Bash
az ad sp create-for-rbac --name $SP_NAME
```
The command will output the credentials of the service principal. Make note of the appId and password<br />

> Get Subscription an Service Principal ID
```Bash
SUB_ID=$(az account show --query id --output tsv)
SP_ID=$(az ad app list --display-name $SP_NAME  | grep  appId | cut -c 15-50)
```
> Assignment Contributer RBAC to Service Principal
```Bash
az role assignment create --assignee $SP_ID --role Contributor --scope /subscriptions/$SUB_ID
```

4. GitHub repositorie to use in Pip

<h1> Steps: </h1>

1. Go to Jenkins Container and install "Terraform Plugin" and "Azure Credentials"

2. After instalation, Go to Manage Jenkins → Global Tool Configuration → Click on Terraform Installations → Enable the Install automatically checkbox

3. Add Service Principal values in a credential

4. Create a new Pipeline Project and configure the pipeline section
- Add "GitHub project"
- Build Triggers - GitHub hook trigger for GITScm polling
- Pipeline - Pipline script from SCM
- SCM - Git 
- Provide GitHub repository link



