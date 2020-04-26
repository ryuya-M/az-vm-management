param (
    # 対象のリソースグループ
    [string]$rg = $null
)

# az login しているか確認
try {
    az account get-access-token --query "tenant" ; if($LASTEXITCODE -ne 0){throw}
} catch {
    az login
}

if([String]::IsNullOrEmpty($rg)){
    az vm list -o table 
    "ResourceGroup を入力してください"
    $rg = read-host
}

"もし、先行して起動したいマシンがある場合は 1 だけ先に起動できます。"
"上記のマシン名からコピペしてください。起動後 1 分待ちます。なんとなく。"
"どうでもいい場合は、何も入力せずに ENTER!!!"
if( ($vmname = read-host) -ne ""){
    az vm start -g $rg -n $vmname
    timeout 60
}

az vm list -g $rg --query "[].id" -o tsv | foreach {az vm start --ids $_ --no-wait}

"end..."
az disk list --query "[].{Name:name,rg:resourceGroup,SKU:sku.name}" -o table