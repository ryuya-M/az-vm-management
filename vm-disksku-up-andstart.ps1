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

write-host "ResourceGroup : $rg 内について SKU を変更し起動させます。"

az vm list -o table -g $rg

$roop = $true
while ($roop){
    "起動するマシン名をコピペしてください。"
    "終了場合は、何も入力せずに ENTER!!!"
    if( ($vmname = read-host) -ne ""){
        $diskname = az disk list -g $rg --query "[].name" -o tsv | where {$_.contains($vmname)} 
        az disk update -g $rg -n $diskname --sku 'StandardSSD_LRS' --no-wait
        az vm start -g $rg -n $vmname --no-wait
    } else {
        "終了します。"
        $roop = $false
    }
}
"ループから抜けました。"
"end..."
az disk list -g $rg --query "[].{Name:name,rg:resourceGroup,SKU:sku.name}" -o table
