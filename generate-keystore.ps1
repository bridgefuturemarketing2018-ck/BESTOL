# Android Keystore Generation Script (Windows)

param(
    [string]$KeystorePath = "release.jks",
    [string]$KeyAlias = "my-key-alias",
    [string]$ValidityDays = "10000"
)

Write-Host "Generating Android Keystore..." -ForegroundColor Green

# Check if keytool is available
$keytoolPath = "keytool"
if (-not (Get-Command $keytoolPath -ErrorAction SilentlyContinue)) {
    Write-Error "keytool not found. Ensure Java is installed and in PATH."
    exit 1
}

# Generate keystore
& $keytoolPath -genkey -v `
    -keystore $KeystorePath `
    -keyalg RSA `
    -keysize 2048 `
    -validity $ValidityDays `
    -alias $KeyAlias

if ($LASTEXITCODE -eq 0) {
    Write-Host "Keystore created: $KeystorePath" -ForegroundColor Green
    
    # Encode to Base64
    $base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($KeystorePath))
    $base64 | Set-Clipboard
    Write-Host "Base64 encoded keystore copied to clipboard!" -ForegroundColor Cyan
} else {
    Write-Error "Keystore generation failed."
    exit 1
}
