param (
    # 対象のリソースグループ
    [string] $rg = $null
)

# az login しているか確認
try {
    az account get-access-token --query "tenant" ; if($LASTEXITCODE -ne 0){throw}
} catch {
    az login
}

if([String]::IsNullOrEmpty($rg)){
    az vm list -o table 
    write-host "ResourceGroup を入力してください"
    $rg = read-host
}

write-host "ResourceGroup : $rg 内のすべての Disk の SKU を変更します。"

az vm list -o table -g $rg
az disk list -g $rg --query "[].id" -o tsv | foreach { az disk update --ids $_ --sku 'StandardSSD_LRS' --no-wait }

"end..."
az disk list --query "[].{Name:name,rg:resourceGroup,SKU:sku.name}" -o table