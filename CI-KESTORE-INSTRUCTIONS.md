# Android Keystore Setup for CI/CD

## Overview
This document explains how to configure Android keystore secrets for automated signing in GitHub Actions.

## Required Secrets
1. **ANDROID_KEYSTORE_BASE64** — Base64-encoded keystore file
2. **ANDROID_KEYSTORE_PASSWORD** — Keystore password
3. **ANDROID_KEY_ALIAS** — Key alias in keystore
4. **ANDROID_KEY_PASSWORD** — Key password

## Setup Steps

### 1. Generate Keystore (if you don't have one)
```bash
keytool -genkey -v -keystore release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```

### 2. Encode Keystore to Base64
```bash
# Linux/Mac
base64 -i release.jks

# Windows PowerShell
[Convert]::ToBase64String([IO.File]::ReadAllBytes('release.jks')) | Set-Clipboard
```

### 3. Add to GitHub Secrets
1. Go to **Settings → Secrets and variables → Actions**
2. Add each secret:
   - `ANDROID_KEYSTORE_BASE64`
   - `ANDROID_KEYSTORE_PASSWORD`
   - `ANDROID_KEY_ALIAS`
   - `ANDROID_KEY_PASSWORD`

## Security Best Practices
- Never commit keystore files to version control
- Rotate keys annually
- Limit keystore access to authorized team members
- Use strong passwords (20+ characters)
