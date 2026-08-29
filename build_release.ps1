# Android Release Build Script (Windows)

param(
    [string]$KeystorePath = "release.jks",
    [string]$KeystorePassword = "",
    [string]$KeyAlias = "my-key-alias",
    [string]$KeyPassword = ""
)

Write-Host "Building signed Android APK..." -ForegroundColor Green

# Validate inputs
if (-not (Test-Path $KeystorePath)) {
    Write-Error "Keystore file not found: $KeystorePath"
    exit 1
}

# Run gradle build
& gradlew.bat assembleRelease `
    -Pandroid.injected.signing.store.file=$KeystorePath `
    -Pandroid.injected.signing.store.password=$KeystorePassword `
    -Pandroid.injected.signing.key.alias=$KeyAlias `
    -Pandroid.injected.signing.key.password=$KeyPassword

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful! APK ready for release." -ForegroundColor Green
    Get-ChildItem -Path "app/build/outputs/apk/release/" -Name
} else {
    Write-Error "Build failed."
    exit 1
}
