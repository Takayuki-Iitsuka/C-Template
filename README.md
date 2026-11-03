# C-Template (AtCoder 向け)

Windows 11 + PowerShell 7 + MinGW gcc / LLVM clang で AtCoder を C 言語で解くためのひな形。

## 構成

```
template/main.c        # 提出用テンプレート（コピー元）
tools/new.ps1          # コンテスト用フォルダ生成
tools/test.ps1         # ビルド + サンプル照合
contests/<contest>/<task>/
    main.c             # 提出するファイル
    in1.txt out1.txt   # サンプル入出力（in2/out2 ... と増やせる）
contests/sample/a      # 動作確認用の例
```

## 使い方

```powershell
.\tools\new.ps1 abc350                          # a〜g を生成
.\tools\new.ps1 arc180 -Tasks a,b,c,d           # 問題を指定
.\tools\test.ps1 contests/abc350/a              # gcc, -O2 でテスト
.\tools\test.ps1 contests/abc350/a -CC clang    # clang
.\tools\test.ps1 contests/abc350/a -Debug       # -O0 -g -DLOCAL
.\tools\test.ps1 contests/abc350/a -CC clang -Sanitize
```

- 提出は `main.c` の中身をそのまま貼る（単一ファイル）。
- `DBG(...)` は `-DLOCAL`（`-Debug`）時だけ stderr に出力され、提出時は無効化される。
- コンパイル設定は AtCoder の C (GCC / Clang) に寄せて `-std=gnu17 -O2` にしている。
  **AtCoder 側の最新のコンパイラ版・オプションは公式のジャッジ環境ページで確認すること**（本テンプレートでは未確認）。
- `-lm` を常にリンクする。
