<#
 コンテスト用フォルダを作成する。
 例: .\tools\new.ps1 abc350            (a〜g を作成)
     .\tools\new.ps1 arc180 -Tasks a,b,c,d
#>
param(
    [Parameter(Mandatory)][string]$Contest,
    [string[]]$Tasks = @('a', 'b', 'c', 'd', 'e', 'f', 'g')
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$tpl = Join-Path $root 'template/main.c'
foreach ($t in $Tasks) {
    $dir = Join-Path $root "contests/$Contest/$t"
    New-Item -ItemType Directory -Force $dir | Out-Null
    $main = Join-Path $dir 'main.c'
    if (-not (Test-Path $main)) { Copy-Item $tpl $main }
    foreach ($f in 'in1.txt', 'out1.txt') {
        $p = Join-Path $dir $f
        if (-not (Test-Path $p)) { New-Item -ItemType File $p | Out-Null }
    }
}
Write-Host "created: contests/$Contest/{$($Tasks -join ',')}  (in1.txt/out1.txt にサンプルを貼る)"
