# ============================================================
# C-Template Makefile  (MinGW gcc / LLVM clang, Windows 向け)
#
#   make                  : gcc で release ビルド
#   make CC=clang         : clang でビルド
#   make BUILD=debug      : debug ビルド（-g -O0）
#   make run              : ビルドして実行
#   make clean            : 成果物を削除
#
# Windows では mingw32-make を使用:  mingw32-make CC=clang
# ============================================================

# make の組み込み既定値 (cc) の場合は gcc を使う
ifeq ($(origin CC),default)
  CC := gcc
endif
TARGET  := app
BUILD   ?= release

SRC_DIR := src
INC_DIR := include
OBJ_DIR := build/$(CC)-$(BUILD)
BIN_DIR := bin

CSTD     := -std=c17
WARNINGS := -Wall -Wextra -Wpedantic
CPPFLAGS += -I$(INC_DIR) -MMD -MP
CFLAGS   += $(CSTD) $(WARNINGS)

ifeq ($(BUILD),debug)
  CFLAGS += -g -O0
else
  CFLAGS += -O2 -DNDEBUG
endif

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

# ---- OS 差異の吸収 ----
ifeq ($(OS),Windows_NT)
  SHELL   := cmd.exe
  EXE     := .exe
  fixpath  = $(subst /,\,$1)
  MKDIR    = if not exist "$(call fixpath,$1)" mkdir "$(call fixpath,$1)"
  RMDIR    = if exist "$(call fixpath,$1)" rmdir /S /Q "$(call fixpath,$1)"
else
  EXE     :=
  fixpath  = $1
  MKDIR    = mkdir -p $1
  RMDIR    = rm -rf $1
endif

BIN := $(BIN_DIR)/$(TARGET)-$(CC)-$(BUILD)$(EXE)

.PHONY: all run clean
all: $(BIN)

$(BIN): $(OBJS) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $(OBJS) -o $@ $(LDLIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_DIR) $(BIN_DIR):
	@$(call MKDIR,$@)

run: $(BIN)
	$(call fixpath,$(BIN))

clean:
	@$(call RMDIR,build)
	@$(call RMDIR,$(BIN_DIR))

-include $(DEPS)
