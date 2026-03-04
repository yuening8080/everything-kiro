#!/bin/bash
set -e

# Everything Kiro — Installer
# Installs steering rules, hooks, and MCP configs into a Kiro project

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GLOBAL_MODE=false
TARGET_DIR=""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
  echo "Usage: $0 [OPTIONS] [TARGET_DIR]"
  echo ""
  echo "Options:"
  echo "  --global    Install to ~/.kiro (user-level, applies to all projects)"
  echo "  --help      Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 /path/to/project     # Install into a specific project"
  echo "  $0 .                    # Install into current directory"
  echo "  $0 --global             # Install globally for all projects"
  echo ""
  echo "Components installed:"
  echo "  steering/always/      → Always-on coding standards"
  echo "  steering/conditional/ → File-match triggered patterns"
  echo "  steering/manual/      → On-demand skills (activate with # in chat)"
  echo "  hooks/                → Agent hooks for automation"
  echo "  mcp/                  → MCP server configurations"
}

for arg in "$@"; do
  case $arg in
    --global)
      GLOBAL_MODE=true
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      TARGET_DIR="$arg"
      ;;
  esac
done

if [ "$GLOBAL_MODE" = true ]; then
  KIRO_DIR="$HOME/.kiro"
  echo -e "${BLUE}Installing Everything Kiro globally to ${KIRO_DIR}${NC}"
elif [ -n "$TARGET_DIR" ]; then
  KIRO_DIR="$TARGET_DIR/.kiro"
  echo -e "${BLUE}Installing Everything Kiro to ${KIRO_DIR}${NC}"
else
  echo "Error: Please specify a target directory or use --global"
  echo ""
  usage
  exit 1
fi

# Create directories
mkdir -p "$KIRO_DIR/steering"
mkdir -p "$KIRO_DIR/hooks"
mkdir -p "$KIRO_DIR/settings"

# Install steering files
echo -e "${GREEN}Installing steering rules...${NC}"

copy_if_not_exists() {
  local src="$1"
  local dest="$2"
  local filename=$(basename "$src")
  if [ -f "$dest/$filename" ]; then
    echo -e "  ${YELLOW}SKIP${NC} $filename (already exists)"
  else
    cp "$src" "$dest/"
    echo -e "  ${GREEN}COPY${NC} $filename"
  fi
}

# Always-on steering
echo ""
echo "Always-on rules:"
for f in "$SCRIPT_DIR/steering/always/"*.md; do
  [ -f "$f" ] && copy_if_not_exists "$f" "$KIRO_DIR/steering"
done

# Conditional steering
echo ""
echo "Conditional rules (file-match):"
for f in "$SCRIPT_DIR/steering/conditional/"*.md; do
  [ -f "$f" ] && copy_if_not_exists "$f" "$KIRO_DIR/steering"
done

# Manual skills
echo ""
echo "Manual skills (on-demand):"
for f in "$SCRIPT_DIR/steering/manual/"*.md; do
  [ -f "$f" ] && copy_if_not_exists "$f" "$KIRO_DIR/steering"
done

# Install hooks
echo ""
echo -e "${GREEN}Installing hooks...${NC}"
for f in "$SCRIPT_DIR/hooks/"*.json; do
  [ -f "$f" ] && copy_if_not_exists "$f" "$KIRO_DIR/hooks"
done

# Install MCP config (merge, don't overwrite)
echo ""
echo -e "${GREEN}Installing MCP configuration...${NC}"
if [ -f "$KIRO_DIR/settings/mcp.json" ]; then
  echo -e "  ${YELLOW}SKIP${NC} mcp.json (already exists — merge manually if needed)"
  echo -e "  ${YELLOW}     ${NC} Reference config at: $SCRIPT_DIR/mcp/mcp.json"
else
  cp "$SCRIPT_DIR/mcp/mcp.json" "$KIRO_DIR/settings/mcp.json"
  echo -e "  ${GREEN}COPY${NC} mcp.json"
fi

echo ""
echo -e "${GREEN}Done!${NC} Everything Kiro installed successfully."
echo ""
echo "What's installed:"
echo "  • $(ls "$SCRIPT_DIR/steering/always/"*.md 2>/dev/null | wc -l | tr -d ' ') always-on steering rules"
echo "  • $(ls "$SCRIPT_DIR/steering/conditional/"*.md 2>/dev/null | wc -l | tr -d ' ') conditional steering rules"
echo "  • $(ls "$SCRIPT_DIR/steering/manual/"*.md 2>/dev/null | wc -l | tr -d ' ') manual skills (activate with # in chat)"
echo "  • $(ls "$SCRIPT_DIR/hooks/"*.json 2>/dev/null | wc -l | tr -d ' ') agent hooks"
echo ""
echo "Next steps:"
echo "  1. Open your project in Kiro"
echo "  2. Steering rules load automatically"
echo "  3. Use # in chat to activate manual skills"
echo "  4. Check Agent Hooks panel to see installed hooks"
