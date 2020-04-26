try {
    az account get-access-token --query "tenant" ; if($LASTEXITCODE -ne 0){throw}
} catch {
    az login
}

az vm list --query "[].id" -o tsv  | foreach {az vm deallocate --ids $_ --no-wait}

az disk list --query "[?sku.name != 'Standard_LRS'].id" -o tsv | foreach {az disk update --ids $_ --sku 'Standard_LRS' --no-wait}

"end..."
az disk list --query "[].{Name:name,rg:resourceGroup,SKU:sku.name}" -o table
