# Azure CLI Command Cookbook

## Official Documentation
- Azure CLI docs: https://learn.microsoft.com/en-us/cli/azure/?view=azure-cli-latest
- Azure reference index: https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

## Preflight and Context
```bash
scripts/az-preflight.sh
scripts/az-auth-status.sh
scripts/az-context.sh
scripts/az-diagnostics.sh --json
```

## Inspect-First Patterns
```bash
az account show --output json
az account list --output table
az group list --output table
az resource list --resource-group <resource-group> --output table
az deployment group list --resource-group <resource-group> --output table
```

## Planned Write Patterns (Confirm First)
```bash
az group create --name <resource-group> --location <location>
az deployment group create --resource-group <resource-group> --template-file <template>
az resource delete --ids <resource-id>
```

## Output Shaping
```bash
az group list --query "[].{name:name,location:location}" --output table
az account show --query "{name:name,id:id,tenantId:tenantId}" --output json
```

## Environment Notes
- Use `AZURE_CONFIG_DIR` when `~/.azure` is not writable.
- Prefer `--query` and explicit `--output` for reproducible command results.
