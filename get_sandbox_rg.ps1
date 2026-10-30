$ErrorActionPreference = "Stop"
try {
    # Check if a custom resource group name was passed or environment variable set
    $groups = az group list -o json | ConvertFrom-Json
    $target = $groups | Where-Object { $_.name -like "*playground-sandbox*" -or ($_.name -notlike "NetworkWatcher*" -and $_.name -notlike "MC_*") } | Select-Object -First 1

    if ($target) {
        @{ name = [string]$target.name } | ConvertTo-Json -Compress
    } else {
        @{ name = "" } | ConvertTo-Json -Compress
    }
} catch {
    @{ name = "" } | ConvertTo-Json -Compress
}

