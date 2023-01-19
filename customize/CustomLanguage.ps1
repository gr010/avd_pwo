# Customize the following variables
$languagePacks="en-US","nl-NL"
$defaultLanguage="nl-NL"
# Start powershell logging
$SaveVerbosePreference = $VerbosePreference
$VerbosePreference = 'continue'
$VMTime = Get-Date
$LogTime = $VMTime.ToUniversalTime()

Start-Transcript -Path "C:\Windows\temp\NMWLogs\ScriptedActions\languages\ps_log.txt" -Append
Write-Host "################# New Script Run #################"
Write-host "Current time (UTC-0): $LogTime"
Write-host "The following language packs will be installed"
Write-Host "$languagePacks"

#Disable Language Pack Cleanup (do not re-enable)
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup" | Out-Null

# Download and install the Language Packs
foreach ($language in $languagePacks)
{
Write-Host "Installing Language Pack for: $language"
Install-Language $language
Write-Host "Installing Language Pack for: $language completed."
}
if ($defaultLanguage -eq $null)
{
Write-Host "Default Language not configured."
}
else
{
Write-Host "Setting default Language to: $defaultLanguage"
Set-SystemPreferredUILanguage $defaultLanguage
}

# End Logging
Stop-Transcript
$VerbosePreference=$SaveVerbosePreference
