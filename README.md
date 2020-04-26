# az-vm-management

Azure CLI を利用して、VM を起動したり、Disk の SKU を変更する自分用のスクリプトを共有。
Azure CLI をインストールしてあれば、何も気にせず、スクリプトを実行してもらえばいい感じになる。

- Start

わりと対話的で使いやすい、[vm-disksku-up-andstart.ps1](./vm-disksku-up-andstart.ps1)

リソースグループに対して一括で行う場合。

Disk を変更して [vm-disksku-up.ps1](./vm-disksku-up.ps1) ＞ 起動させる [vm-start-rg.ps1](./vm-start-rg.ps1)

- end

[vm-disksku-down-all.ps1](./vm-disksku-down-all.ps1)
