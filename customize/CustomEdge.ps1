# Edge registry keys!

## Usage: https://docs.microsoft.com/en-us/deployedge/microsoft-edge-policies

# Logging
# $BuildFolder = "C:\imageBuilder"
# $BuildingBlock = "Edge"
# Start-Transcript -Path (Join-Path -Path $BuildFolder -ChildPath "$BuildingBlock.log")
# Write-Output "Configuring $BuildingBlock"

# Place Edge link to startup
# $installFolder = "C:\imageBuilder\avdBranding"
# Write-Host "Install folder: $installFolder"
# Write-Host "Placing Edge shortcut in startup folder"
# Copy-Item "$($installFolder)Edge.url" "c:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Edge.url" -Force

# Variables
$registryPath1 = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
$registryPath2 = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended"
$registryPath3 = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended\RestoreOnStartupURLs"
$registryPath4 = "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate"
$HomePage = "edge://favorites"

# Registry keys to configure
$HideFirstRunExperience = "HideFirstRunExperience" # $registryPath1
$SyncDisabled = "SyncDisabled" # $registryPath1
$TrackingPrevention = "TrackingPrevention" # $registryPath1
$PasswordManagerEnabled = "PasswordManagerEnabled" # $registryPath1
$RestoreOnStartup = "RestoreOnStartup" # $registryPath2
$BackgroundModeEnabled = "BackgroundModeEnabled" # $registryPath2
$HomepageIsNewTabPage = "HomepageIsNewTabPage" # $registryPath2
$HomePageLocation = "HomePageLocation" # $registryPath2
$NewTabPageLocation = "NewTabPageLocation" # $registryPath2
$RestoreOnStartup = "RestoreOnStartup" # $registryPath3
$RestoreOnStartupURLs = "RestoreOnStartupURLs" # $registryPath3
$1 = "1" # $registryPath3
$CreateDesktopShortcut = "CreateDesktopShortcut{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"

# Set keys on $registryPath1
if (-not (Test-Path $registryPath1)){ # Checking if key exists, else creating key
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "Edge" -Force | Out-Null
}
if (Test-Path $registryPath1){ # setting the keys + values
    Set-ItemProperty -Path $registryPath1 -Name $HideFirstRunExperience -Value "1" -Type DWORD # Skip FirstRun
    Set-ItemProperty -Path $registryPath1 -Name $SyncDisabled -Value "1" -Type DWORD # Microsoft Account sync disabled
    Set-ItemProperty -Path $registryPath1 -Name $PasswordManagerEnabled -Value '0' -Type DWORD # Passwordmanager disable
    Set-ItemProperty -Path $registryPath1 -Name $TrackingPrevention -Value "3" -Type DWORD # Force strict tracking prevention
}

# Set keys on $registryPath2
if (-not (Test-Path $registryPath2)){ # Checking if key exists, else creating key
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "Recommended" -Force | Out-Null
}
if (Test-Path $registryPath2){ # Setting the keys + values
    Set-ItemProperty -Path $registryPath2 -Name $BackgroundModeEnabled -Value "1" -Type DWORD # Disable background
    Set-ItemProperty -Path $registryPath2 -Name $RestoreOnStartup -Value "4" -Type DWORD # Set HomePage step
    Set-ItemProperty -Path $registryPath2 -Name $HomepageIsNewTabPage -Value "1" # Set HomePage step
    Set-ItemProperty -Path $registryPath2 -Name $HomePageLocation -Value $HomePage -Type String # Set HomePage step
    Set-ItemProperty -Path $registryPath2 -Name $NewTabPageLocation -Value $HomePage -Type String # Set HomePage step
}

# Set keys on $registryPath3
if (-not (Test-Path $registryPath3)){ # Checking if key exists, else creating key
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge\Recommended" -Name $RestoreOnStartupURLs -Force | Out-Null
}
if (Test-Path $registryPath3){ # Setting the keys + values
    Set-ItemProperty -Path $registryPath3 -Name $1 -Value $HomePage -Type String # Set HomePage
}

# Set keys on $registryPath4
if (-not (Test-Path $registryPath4)){ # Checking if key exists, else creating key
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "EdgeUpdate" -Force | Out-Null
}
if (Test-Path $registryPath4){ # Setting the keys + values
    Set-ItemProperty -Path $registryPath4 -Name $CreateDesktopShortcut -Value "0" -Type DWORD # Create Desktop Shortcut
}

# Stop-Transcript

exit 0 #done
