#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${PURPLE}🚀 Installing github-ssh-key-setup...${NC}\n"

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

RAW_URL="https://raw.githubusercontent.com/Praveensenpai/github-ssh-key-setup/main/bin/github-ssh-key-setup"

LOCAL_DIR=""
if [ -n "${BASH_SOURCE[0]}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
fi

if [ -n "$LOCAL_DIR" ] && [ -f "$LOCAL_DIR/PKGBUILD" ] && [ -f "$LOCAL_DIR/bin/github-ssh-key-setup" ]; then
    cp "$LOCAL_DIR/bin/github-ssh-key-setup" "$BIN_DIR/github-ssh-key-setup"
else
    echo -e "${BLUE}📦 Downloading github-ssh-key-setup binary from GitHub...${NC}"
    curl -sSL -H 'Cache-Control: no-cache' "$RAW_URL" -o "$BIN_DIR/github-ssh-key-setup"
fi

if [ ! -f "$BIN_DIR/github-ssh-key-setup" ] || [ ! -s "$BIN_DIR/github-ssh-key-setup" ]; then
    echo -e "${RED}❌ Error: Failed to download github-ssh-key-setup binary!${NC}"
    exit 1
fi

chmod +x "$BIN_DIR/github-ssh-key-setup"
echo -e "${GREEN}✔ Installed github-ssh-key-setup to ${BIN_DIR}/github-ssh-key-setup${NC}"

SHELL_CONFIGS=("$HOME/.bashrc" "$HOME/.zshrc")
ALIAS_LINE="alias github-ssh-key-setup='$HOME/.local/bin/github-ssh-key-setup'"

for config in "${SHELL_CONFIGS[@]}"; do
    if [ -f "$config" ]; then
        if ! grep -q "alias github-ssh-key-setup=" "$config" 2>/dev/null; then
            echo "" >> "$config"
            echo "$ALIAS_LINE" >> "$config"
            echo -e "${BLUE}📝 Added github-ssh-key-setup alias to $config${NC}"
        fi
    fi
done

echo -e "\n${GREEN}${BOLD}▶ Running GitHub SSH setup...${NC}"
"$BIN_DIR/github-ssh-key-setup"
