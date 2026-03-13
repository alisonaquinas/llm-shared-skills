# xml2 / 2xml — Windows Installation
#
# xml2 and 2xml have no native Windows binary.
# Use WSL (Windows Subsystem for Linux) and install via apt-get inside WSL.

Write-Host "xml2 and 2xml require WSL on Windows."
Write-Host ""
Write-Host "Install WSL if not already installed:"
Write-Host "  wsl --install"
Write-Host ""
Write-Host "Then inside WSL, run:"
Write-Host "  sudo apt-get update && sudo apt-get install -y xml2"
Write-Host ""
Write-Host "To run xml2 from PowerShell via WSL:"
Write-Host "  wsl xml2 < file.xml"
Write-Host "  Get-Content file.xml | wsl xml2"
