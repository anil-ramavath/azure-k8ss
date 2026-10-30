#!/usr/bin/env sh
# POSIX-compliant shell script: works in bash, sh, dash, zsh on Linux, macOS, WSL

# Query resource groups using az CLI directly
rg=$(az group list --query "[?contains(name, 'playground-sandbox') || (!starts_with(name, 'NetworkWatcher') && !starts_with(name, 'MC_'))].name | [0]" -o tsv 2>/dev/null || echo "")

if [ -n "$rg" ]; then
  printf '{"name":"%s"}\n' "$rg"
else
  printf '{"name":""}\n'
fi
