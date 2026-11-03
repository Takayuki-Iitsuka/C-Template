<#
 main.c をビルドし、in*.txt を入力して out*.txt と照合する。
 例: .\tools\test.ps1 contests/abc350/a
     .\tools\test.ps1 contests/abc350/a -CC clang -Debug
 -Debug : -O0 -g -DLOCAL（DBG() が stderr に出力される）
 -Sanitize : -fsanitize=undefined を追加（clang 推奨）
#>
param(
    [Parameter(Mandatory)][string]$Dir,
    [ValidateSet('gcc', 'clang')][string]$CC = 'gcc',
    [switch]$Debug,
    [switch]$Sanitize
)
$ErrorActionPreference = 'Stop'
$Dir = (Resolve-Path $Dir).Path
$exe = Join-Path $Dir 'a.exe'
# AtCoder の C (GCC / Clang) に合わせた設定: gnu17, -O2
$flags = @('-std=gnu17', '-Wall', '-Wextra')
if ($Debug) { $flags += '-O0', '-g', '-DLOCAL' } else { $flags += '-O2' }
if ($Sanitize) { $flags += '-fsanitize=undefined' }

& $CC @flags (Join-Path $Dir 'main.c') -o $exe -lm
if ($LASTEXITCODE -ne 0) { Write-Host 'COMPILE ERROR' -ForegroundColor Red; exit 1 }

$fail = 0; $n = 0
foreach ($in in Get-ChildItem $Dir -Filter 'in*.txt' | Sort-Object Name) {
    $id = $in.BaseName.Substring(2)
    $expFile = Join-Path $Dir "out$id.txt"
    if (-not (Test-Path $expFile)) { continue }
    $n++
    $actual = (Get-Content $in.FullName -Raw | & $exe) -join "`n"
    $code = $LASTEXITCODE
    $expected = (Get-Content $expFile -Raw).TrimEnd()
    if ($code -eq 0 -and $actual.TrimEnd() -eq $expected) {
        Write-Host "case ${id}: AC" -ForegroundColor Green
    } else {
        $fail++
        Write-Host "case ${id}: WA/RE (exit=$code)" -ForegroundColor Red
        Write-Host "--- expected`n$expected`n--- actual`n$actual"
    }
}
Write-Host "$($n - $fail)/$n passed"
exit ($fail -gt 0 ? 1 : 0)
