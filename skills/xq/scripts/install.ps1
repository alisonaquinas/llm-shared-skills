# Install jq and xq (via yq Python package) on Windows

# Install jq via winget
Write-Host "Installing jq..."
winget install jqlang.jq

# Install yq (provides xq) via pip
Write-Host "Installing yq (provides xq)..."
pip install yq

Write-Host ""
Write-Host "Verify installation:"
Write-Host "  jq --version"
Write-Host "  xq --version"
Write-Host ""
Write-Host "Note: Restart your terminal for PATH changes to take effect."
