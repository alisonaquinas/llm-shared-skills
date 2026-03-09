# Security And Compatibility

Use this reference when the task touches execution policy, signing, least privilege, secrets handling, constrained environments, or Windows PowerShell 5.1 compatibility.

## Execution policy

- Execution policy is a safety feature, not a security boundary.
- `pwsh -ExecutionPolicy Bypass` affects the current process on Windows only.
- Explain scope clearly when answering policy questions: Process, CurrentUser, LocalMachine, and effective policy.

```powershell
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope Process Bypass
```

## Secrets boundaries

- Prefer secret stores, environment injection, or secure prompts over plaintext files.
- Avoid writing secrets to transcripts, history, verbose output, or world-readable temp files.
- Be explicit about where credentials live and how long they persist.

### Microsoft.PowerShell.SecretManagement

```powershell
Install-Module Microsoft.PowerShell.SecretManagement -Scope CurrentUser
Install-Module Microsoft.PowerShell.SecretStore -Scope CurrentUser

Register-SecretVault -Name local -ModuleName Microsoft.PowerShell.SecretStore
Set-Secret -Name 'MyApiKey' -Secret 'abc123' -Vault local
$key = Get-Secret -Name 'MyApiKey' -AsPlainText
```

- `SecretManagement` is the abstraction layer; `SecretStore` is the default local vault.
- Third-party vaults (Azure Key Vault, 1Password, KeePass) use the same API surface via registered vault extensions.
- `-AsPlainText` returns a string; omit it to receive a `SecureString`.

## Code signing

- Mention code signing when the request is about trusted script execution or enterprise distribution.
- Separate signing guidance from execution policy guidance; they are related but not the same control.

## Constrained environments

- Constrained Language Mode, Just Enough Administration, and locked-down endpoints can limit available language features.
- Remoting endpoints and session configurations may intentionally remove commands and language features.

## Script-level error promotion

```powershell
# At the top of a script to make all non-terminating errors terminating
$ErrorActionPreference = 'Stop'
```

- Equivalent to adding `-ErrorAction Stop` to every cmdlet call.
- Use at the top of automation scripts where any unexpected error should abort execution.
- Restore with `$ErrorActionPreference = 'Continue'` if a section must tolerate errors.

## Compatibility

- Windows PowerShell 5.1 runs on .NET Framework and includes older Windows-centric modules.
- PowerShell 7+ runs on modern .NET and is cross-platform.
- Some Windows modules import through compatibility shims or only work in 5.1.

```powershell
$PSVersionTable
$PSVersionTable.PSEdition
```

## What to call out in answers

- Whether the recommendation is Windows-only.
- Whether the user needs a temporary workaround or a policy-compliant long-term fix.
- Whether a module or script must run in 5.1 instead of 7+.
