# 漢字を ps1 file 内で使うときの Tips

https://thinkami.hatenablog.com/entry/2016/07/08/065709

VS Codeでファイルを新規作成するときのデフォルトの文字コードが UTF-8 (BOMなし)のためです。

　
試しに、日本語が含まれるps1ファイルの文字コードを

UTF-8 BOMあり
UTF-16 BE (Big Endian)
UTF-16 LE (Little Endian)
Shift-JIS
などにして実行した場合、

Hello world!
ハローワールド!
と正しく表示されました。

　
どの文字コードで保存しておくのが良いのか調べてみたところ、

Powershellスクリプト（.ps1、.psm）の文字コードに関して
PowerShell 自己署名証明書を追加するとUnknownErrorが表示される～Set-AuthenticodeSignature - 元「なんでもエンジニ屋」のダメ日記
"Set-AuthenticodeSignature" returns Unknown Error while registering the script with a certificate | Vijay – Blog Space
より、UTF-8 with BOMが良さそうでした。

## ファイルの出力については以下。

https://qiita.com/watahani/items/3cb6a9d00d5dc1e2ba73
