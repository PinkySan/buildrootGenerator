<#
.SYNOPSIS
    Installiert LLVM/Clang für Windows in der gewünschten Version (silent).
.DESCRIPTION
    Lädt das LLVM-Installer-EXE für die angegebene Version herunter und installiert sie silent.
    Optional kann ein Installationsverzeichnis angegeben werden.
.PARAMETER Version
    Die LLVM-Version, die installiert werden soll (z.B. "20.1.8").
.PARAMETER InstallDir
    Optional: Zielverzeichnis für die Installation (z.B. "C:\\LLVM-20").
.EXAMPLE
    .\install-llvm.ps1 -Version "20.1.8" -InstallDir "C:\\LLVM-20"
    .\install-llvm.ps1 -Version "20.1.8"
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$Version,
    [string]$InstallDir
)

$ErrorActionPreference = 'Stop'

# Download-URL für LLVM-Installer (GitHub Releases)
$baseUrl = "https://github.com/llvm/llvm-project/releases/download/llvmorg-$Version/LLVM-$Version-win64.exe"
$installer = "LLVM-$Version-win64.exe"

Write-Host "Lade LLVM $Version herunter..."
Invoke-WebRequest -Uri $baseUrl -OutFile $installer

# Silent-Installationsparameter
$silentArgs = "/S"
if ($InstallDir) {
    $silentArgs += " /D=$InstallDir"
    Write-Host "Installiere nach $InstallDir ..."
} else {
    Write-Host "Installiere in das Standardverzeichnis ..."
}

# Installation ausführen
Write-Host "Starte Silent-Installation..."
Start-Process -FilePath ".\$installer" -ArgumentList $silentArgs -Wait

Write-Host "LLVM $Version wurde installiert."

# Optional: Installer löschen
Remove-Item ".\$installer" -Force
