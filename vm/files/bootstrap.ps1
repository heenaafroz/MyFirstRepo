

# install-choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Azure Cli
try {
    $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
}
catch {
    Write-Error $_
}

# postman
choco install postman --version=9.29.0 -y

# git
choco install git -y
    
# googlechrome
choco install chocolatey-core.extension -y -force --ignore-checksums
choco install googlechrome -y --ignore-checksums

# Jfrog
choco install jfrog-cli -y

# k9s
choco install k9s -y

# kubectl
az aks install-cli
#choco install kubernetes-cli -y

# helm
choco install kubernetes-helm -y

# vscode
choco install vscode -y

# azure-data-studio
choco install azure-data-studio -y

# sql-server-management-studio
choco install sql-server-management-studio -y

# flux
choco install flux -y


# Users
net user devops Password012$ /add
net localgroup administrators devops /add


# Redis
$Uri = 'https://download.redisinsight.redis.com/latest/RedisInsight-v2-win-installer.exe'
$Result=Invoke-WebRequest -Uri $Uri -UseBasicParsing -OutFile "D:\RedisInsight-v2-win-installer.exe" -Verbose
Invoke-Expression -Command "D:\RedisInsight-v2-win-installer.exe /S" -Verbose -ErrorAction Stop

# CleanUp
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
$ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

$config
cd $wingetpath
winget uninstall "windows web experience pack" --accept-source-agreements
winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.OneDriveSync_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.WindowsMaps_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.Todos_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.MicrosoftTeams_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe --accept-source-agreements
winget uninstall "{2FA9DAAC-895B-4E99-99D9-DC2965FBE79C}" --accept-source-agreements
winget uninstall CorelCorporation.PaintShopPro_wbjqpk9xt50t4 --accept-source-agreements
winget uninstall MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy --accept-source-agreements
winget uninstall Microsoft.Windows.Photos_8wekyb3d8bbwe --accept-source-agreements
winget uninstall Microsoft.OneDrive --accept-source-agreements
