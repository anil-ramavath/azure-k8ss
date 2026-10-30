@echo off
setlocal

REM Auto-discovery for Windows (CMD / PowerShell)
for /f "usebackq delims=" %%i in (`az group list --query "[?contains(name, 'playground-sandbox') || (!starts_with(name, 'NetworkWatcher') && !starts_with(name, 'MC_'))].name | [0]" -o tsv 2^>nul`) do (
    set "RG_NAME=%%i"
)

if defined RG_NAME (
    echo {"name":"%RG_NAME%"}
) else (
    echo {"name":""}
)
