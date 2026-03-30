#!/bin/bash
# ============================================================
#   KP/OS Installer
#   
#   Open Terminal, type: bash 
#   Then drag this file into the Terminal window.
#   Press Enter.
# ============================================================

set -e

# ── Colors ──────────────────────────────────────────────────
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
DIM='\033[2m'
BOLD='\033[1m'
WHITE='\033[1;37m'
RESET='\033[0m'

# ── Helper functions ────────────────────────────────────────
print_check() {
    echo -e "  ${GREEN}✓${RESET} $1"
}

print_pending() {
    echo -e "  ${DIM}☐${RESET} $1"
}

print_step() {
    echo ""
    echo -e "  ${CYAN}▸${RESET} ${BOLD}$1${RESET}"
}

print_info() {
    echo -e "  ${DIM}$1${RESET}"
}

print_error() {
    echo -e "  ${PURPLE}✗${RESET} $1"
}

press_enter() {
    echo ""
    echo -e "  ${DIM}Press Enter to continue...${RESET}"
    read -r
}

# ── Locate the package ──────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Verify this is actually the KP/OS package
if [ ! -d "$SCRIPT_DIR/.claude/commands" ]; then
    echo ""
    print_error "Can't find KP/OS package files."
    print_info "Make sure setup.sh is in the same folder as the extracted package."
    echo ""
    exit 1
fi

# ── Splash screen ───────────────────────────────────────────
clear
echo ""
echo -e "${PURPLE}  ██╗  ██╗ ██████╗    ██╗     ██████╗ ███████╗${RESET}"
echo -e "${PURPLE}  ██║ ██╔╝ ██╔══██╗  ██╔╝    ██╔═══██╗██╔════╝${RESET}"
echo -e "${PURPLE}  █████╔╝  ██████╔╝ ██╔╝     ██║   ██║███████╗${RESET}"
echo -e "${PURPLE}  ██╔═██╗  ██╔═══╝ ██╔╝      ██║   ██║╚════██║${RESET}"
echo -e "${PURPLE}  ██║  ██╗ ██║    ██╔╝       ╚██████╔╝███████║${RESET}"
echo -e "${PURPLE}  ╚═╝  ╚═╝ ╚═╝    ╚═╝         ╚═════╝ ╚══════╝${RESET}"
echo ""
echo -e "  ${DIM}by Kesal Patel  ·  v1.0${RESET}"
echo ""
echo -e "  ${WHITE}A personal operating system.${RESET}"
echo -e "  ${DIM}Digital second brain built on an AI-powered knowledge graph.${RESET}"
echo ""
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  This sets up an AI-powered knowledge management"
echo -e "  system on your Mac. It installs Obsidian (where"
echo -e "  your notes live) and Claude Code (the AI that"
echo -e "  helps you manage them), then walks you through"
echo -e "  personalizing it for your role and work."
echo ""
echo -e "  ${CYAN}What this installer will do:${RESET}"
echo ""
print_pending "Homebrew              ${DIM}package manager${RESET}"
print_pending "Claude Code           ${DIM}AI terminal agent${RESET}"
print_pending "Obsidian              ${DIM}knowledge base${RESET}"
print_pending "Vault workspace       ${DIM}your second brain${RESET}"
print_pending "Plugins & config      ${DIM}ready to go${RESET}"
print_pending "Personalization       ${DIM}make it yours${RESET}"
echo ""
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${DIM}Takes about 5 minutes.${RESET}"

press_enter

# ── Step 1: Homebrew ────────────────────────────────────────
print_step "Checking for Homebrew..."

if command -v brew &>/dev/null; then
    print_check "Homebrew installed"
else
    echo ""
    print_error "Homebrew is not installed."
    echo ""
    echo -e "  Homebrew is a package manager for Mac."
    echo -e "  To install it, paste this into Terminal:"
    echo ""
    echo -e "  ${WHITE}/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${RESET}"
    echo ""
    echo -e "  After it finishes, run this setup script again."
    echo ""
    exit 1
fi

# ── Step 2: Claude Code ────────────────────────────────────
print_step "Checking for Claude Code..."

if command -v claude &>/dev/null; then
    print_check "Claude Code installed"
else
    echo -e "  ${DIM}Brewing the essentials...${RESET}"
    brew install claude-code 2>/dev/null
    if command -v claude &>/dev/null; then
        print_check "Claude Code installed"
    else
        print_error "Claude Code installation failed."
        echo -e "  Try running: ${WHITE}brew install claude-code${RESET}"
        exit 1
    fi
fi

# ── Step 3: Obsidian ───────────────────────────────────────
print_step "Checking for Obsidian..."

if [ -d "/Applications/Obsidian.app" ]; then
    print_check "Obsidian installed"
else
    echo -e "  ${DIM}Installing Obsidian...${RESET}"
    brew install --cask obsidian 2>/dev/null
    if [ -d "/Applications/Obsidian.app" ]; then
        print_check "Obsidian installed"
    else
        print_error "Obsidian installation failed."
        echo -e "  Try running: ${WHITE}brew install --cask obsidian${RESET}"
        exit 1
    fi
fi

# ── Step 4: Vault location ─────────────────────────────────
print_step "Where should your vault live?"
echo ""
echo -e "  ${WHITE}1)${RESET} Documents folder ${DIM}(~/Documents/vault — simple, local)${RESET}"
echo -e "  ${WHITE}2)${RESET} iCloud ${DIM}(syncs across all your Apple devices)${RESET}"
echo -e "  ${WHITE}3)${RESET} Custom location ${DIM}(you tell me the path)${RESET}"
echo ""
read -p "  Pick 1, 2, or 3: " LOCATION_CHOICE

case "$LOCATION_CHOICE" in
    1)
        VAULT_PATH="$HOME/Documents/vault"
        ;;
    2)
        VAULT_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault"
        ;;
    3)
        echo ""
        read -p "  Enter the full path: " VAULT_PATH
        # Expand ~ if used
        VAULT_PATH="${VAULT_PATH/#\~/$HOME}"
        ;;
    *)
        VAULT_PATH="$HOME/Documents/vault"
        echo -e "  ${DIM}Defaulting to ~/Documents/vault${RESET}"
        ;;
esac

# Check if vault already exists
if [ -d "$VAULT_PATH" ] && [ "$(ls -A "$VAULT_PATH" 2>/dev/null)" ]; then
    echo ""
    print_error "That folder already has files in it: $VAULT_PATH"
    echo -e "  Pick an empty location or remove existing files first."
    exit 1
fi

print_check "Vault location: $VAULT_PATH"

# ── Step 5: Copy vault files ───────────────────────────────
print_step "Building your workspace..."

mkdir -p "$VAULT_PATH"

# Copy everything except setup.sh, README.md, and _plugins
rsync -a --exclude='setup.sh' --exclude='README.md' --exclude='_plugins/' "$SCRIPT_DIR/" "$VAULT_PATH/"

print_check "Vault structure created"

# ── Step 6: Open in Obsidian to generate .obsidian/ ────────
print_step "Wiring up Obsidian..."

# Check if Obsidian CLI is available
OBSIDIAN_CLI="/Applications/Obsidian.app/Contents/MacOS/obsidian"

if [ -x "$OBSIDIAN_CLI" ]; then
    # Open the vault in Obsidian (this creates .obsidian/)
    open "obsidian://open?path=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$VAULT_PATH'))")" 2>/dev/null
    
    # Wait for .obsidian to be created
    echo -e "  ${DIM}Waiting for Obsidian to initialize...${RESET}"
    WAIT_COUNT=0
    while [ ! -d "$VAULT_PATH/.obsidian" ] && [ $WAIT_COUNT -lt 30 ]; do
        sleep 1
        WAIT_COUNT=$((WAIT_COUNT + 1))
    done
    
    if [ -d "$VAULT_PATH/.obsidian" ]; then
        print_check "Obsidian vault initialized"
    else
        echo -e "  ${DIM}Obsidian is taking a moment. Creating config manually...${RESET}"
        mkdir -p "$VAULT_PATH/.obsidian"
    fi
else
    # Fallback: create .obsidian manually
    mkdir -p "$VAULT_PATH/.obsidian"
    print_check "Obsidian config created"
fi

# Small delay to let Obsidian finish writing defaults
sleep 2

# ── Step 7: Install plugins ────────────────────────────────
print_step "Installing plugins..."

PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"
mkdir -p "$PLUGINS_DIR"

# Copy plugins from the package
if [ -d "$SCRIPT_DIR/_plugins" ]; then
    for plugin_dir in "$SCRIPT_DIR/_plugins"/*/; do
        plugin_name=$(basename "$plugin_dir")
        if [ "$plugin_name" = "granola-sync-plus" ]; then
            # Skip Granola for now — bootstrap will ask if they want it
            continue
        fi
        cp -R "$plugin_dir" "$PLUGINS_DIR/"
        print_check "$plugin_name"
    done
else
    print_error "Plugin package not found. Plugins will need manual installation."
    print_info "See _meta/recommended-plugins.md for the list."
fi

# ── Step 8: Write Obsidian config ──────────────────────────
print_step "Configuring Obsidian settings..."

# app.json — core settings
cat > "$VAULT_PATH/.obsidian/app.json" << 'APPJSON'
{
  "userIgnoreFilters": [
    "node_modules",
    ".git",
    ".next",
    "build",
    ".venv",
    "__pycache__",
    "**/files"
  ],
  "alwaysUpdateLinks": true,
  "newFileLocation": "folder",
  "attachmentFolderPath": "attachments",
  "newFileFolderPath": "agent-output"
}
APPJSON

# core-plugins.json — enable daily notes, backlinks, etc.
cat > "$VAULT_PATH/.obsidian/core-plugins.json" << 'COREJSON'
{
  "file-explorer": true,
  "global-search": true,
  "switcher": true,
  "graph": true,
  "backlink": true,
  "canvas": true,
  "outgoing-link": true,
  "tag-pane": true,
  "properties": true,
  "page-preview": true,
  "daily-notes": true,
  "templates": true,
  "note-composer": true,
  "command-palette": true,
  "editor-status": true,
  "bookmarks": true,
  "outline": true,
  "word-count": true,
  "file-recovery": true,
  "bases": true
}
COREJSON

# daily-notes.json — configure daily notes
cat > "$VAULT_PATH/.obsidian/daily-notes.json" << 'DAILYJSON'
{
  "folder": "daily-notes",
  "template": "templates/daily-note"
}
DAILYJSON

# community-plugins.json — enable installed plugins
cat > "$VAULT_PATH/.obsidian/community-plugins.json" << 'COMMJSON'
[
  "obsidian-tasks-plugin",
  "obsidian-auto-link-title",
  "calendar",
  "dataview",
  "templater-obsidian",
  "various-complements",
  "terminal"
]
COMMJSON

print_check "Obsidian configured"

# ── Step 9: Clean up ───────────────────────────────────────
# Remove the _plugins staging folder from the vault (it was only for setup)
rm -rf "$VAULT_PATH/_plugins" 2>/dev/null

# Remove setup.sh and README from vault if they somehow got copied
rm -f "$VAULT_PATH/setup.sh" 2>/dev/null
rm -f "$VAULT_PATH/README.md" 2>/dev/null

# Remove .gitkeep files (they were only to preserve empty dirs in the zip)
find "$VAULT_PATH" -name ".gitkeep" -delete 2>/dev/null

print_check "Cleaned up installer files"

# ── Step 10: Save vault path for bootstrap ──────────────────
# Write a temp file that /bootstrap can read to know the vault path
echo "$VAULT_PATH" > "$VAULT_PATH/.claude/.vault-path"

# ── Done ────────────────────────────────────────────────────
echo ""
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${GREEN}✓${RESET} ${BOLD}KP/OS installed successfully.${RESET}"
echo ""
echo -e "  ${GREEN}✓${RESET} Homebrew"
echo -e "  ${GREEN}✓${RESET} Claude Code"
echo -e "  ${GREEN}✓${RESET} Obsidian"
echo -e "  ${GREEN}✓${RESET} Vault workspace"
echo -e "  ${GREEN}✓${RESET} Plugins & config"
echo -e "  ${DIM}☐${RESET} Personalization       ${DIM}← next step${RESET}"
echo ""
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${WHITE}One last step — let's make it yours.${RESET}"
echo ""
echo -e "  Obsidian should be open with your vault."
echo -e "  Look for the ${WHITE}Terminal${RESET} panel at the bottom."
echo -e "  ${DIM}(If you don't see it, press Cmd+\` or look${RESET}"
echo -e "  ${DIM}under the three-dot menu → Terminal)${RESET}"
echo ""
echo -e "  In that terminal, type:"
echo ""
echo -e "    ${WHITE}claude${RESET}"
echo ""
echo -e "  Then once Claude Code is running, type:"
echo ""
echo -e "    ${WHITE}/bootstrap${RESET}"
echo ""
echo -e "  It'll ask you a few questions about your"
echo -e "  role, team, and work — then set everything up."
echo ""
echo -e "  ${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
echo -e "  ${DIM}Vault path: $VAULT_PATH${RESET}"
echo ""
