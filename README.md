## Azure CLi

Initially, it needs to create some resources on Azure

```sh
 # Login to Azure
az login

# Create storage for Terraform state
az group create --name buridogs-tfstate-rg --location eastus2

az storage account create \
  --name buridogstfstate \
  --resource-group buridogs-tfstate-rg \
  --location eastus2 \
  --sku Standard_LRS

az storage container create \
  --name tfstate \
  --account-name buridogstfstate

# Initialize Terraform
terraform init \
  -backend-config="resource_group_name=buridogs-tfstate-rg" \
  -backend-config="storage_account_name=buridogstfstate" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=prod.terraform.tfstate"
```

After that

```sh
# Plan with specific environment
terraform plan -var-file="environments/prod.tfvars"

# Apply changes
terraform apply -var-file="environments/prod.tfvars"
```

### References

- Documentation: https://learn.microsoft.com/pt-br/cli/azure/install-azure-cli-macos?view=azure-cli-latest
