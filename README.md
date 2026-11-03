# C-Template

Windows 11 + MinGW (gcc) / LLVM (clang) 向けの C 言語プロジェクトひな形。ターミナルから `make` でビルドします。

## 構成

```
.
├── Makefile
├── include/   # ヘッダ (*.h)
├── src/       # ソース (*.c, main.c を含む)
├── build/     # オブジェクト・依存ファイル（自動生成）
└── bin/       # 実行ファイル（自動生成）
```

`src/*.c` は自動で収集されるため、ファイル追加時に Makefile の修正は不要です。

## 使い方（PowerShell）

```powershell
mingw32-make                    # gcc で release ビルド
mingw32-make CC=clang           # clang でビルド
mingw32-make BUILD=debug        # debug ビルド (-g -O0)
mingw32-make run                # ビルドして実行
mingw32-make clean              # build/ と bin/ を削除
```

`make` コマンドが別名で入っている環境では `make` に読み替えてください。
出力は `bin/app-<compiler>-<build>.exe`（例: `bin/app-gcc-release.exe`）。

## 前提

- MinGW-w64 (`gcc`, `mingw32-make`) と LLVM (`clang`) が `PATH` に通っていること
- 規格は C17、警告は `-Wall -Wextra -Wpedantic`
