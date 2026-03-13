# Install xmllint on Windows via Chocolatey (includes libxml2)
#
# Requires Chocolatey: https://chocolatey.org/install

Write-Host "Installing xsltproc (includes xmllint) via Chocolatey..."
choco install xsltproc -y

Write-Host ""
Write-Host "Verify installation:"
Write-Host "  xmllint --version"
Write-Host ""
Write-Host "Alternative: download Windows binaries from:"
Write-Host "  https://www.zlatkovic.com/libxml.en.html"
