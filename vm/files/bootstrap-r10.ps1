param(
$jfrog_user = $env:jfrog_user,
$jfrog_api_key = $env:jfrog_api_key,
$jfrog_base_url = "https://ncr.jfrog.io/artifactory",
$artifactory_type = "r10-generic-snapshots/Tools",
$artifactory_download_path = "D:\"
)

# install-choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Azure Cli
try {
    $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
}
catch {
    Write-Error $_
}

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

# flux
choco install flux -y

# notepadplusplus
choco install notepadplusplus -y

### R10 Pre-Req

# disable-firewall
Write-Verbose "Config prerequisites: Disabling Firewall" -Verbose
NetSh Advfirewall set allprofiles state off

# disable-uac
try {
    Write-Verbose "Config prerequisites: Disabling UA" -Verbose
    New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -PropertyType DWord -Value 0 -Force -Verbose -ErrorAction Stop
    New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -PropertyType DWord -Value 0 -Force -Verbose -ErrorAction Stop
    New-Item -ItemType "directory" -Path "c:\build" -force

}
catch {
    Write-Error $_
}
    
# 3rdparty-psmodules

try {

   # download
   $download_url =  "$artifactory_type/Modules/Modules.zip"
   
   $ENV:JFROG_CLI_OFFER_CONFIG="false"
   $ENV:CI="true"
   jfrog rt download "$download_url" "$artifactory_download_path" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=$jfrog_base_url --threads=6 --flat=true
   write-output "ARTIFACTORY DOWNLOAD URL: $download_url"
   write-output "ARTIFACTORY DOWNLOAD PATH: $artifactory_download_path"

   # install
   Write-Verbose "### Installing prerequisites: Modules.zip ###" -Verbose
   
    Expand-Archive "$artifactory_download_path\Modules.zip" -DestinationPath "C:\Program Files\WindowsPowerShell\Modules\" 
    
   # clean file
    remove-Item "$artifactory_download_path\Modules.zip" -force -confirm:$false -Verbose
}catch{
    $ErrorMessage = $_.Exception.Message
    write-error $ErrorMessage
    exit 1
    Break
}    


#windows-feature-2022

try {

$ENV:JFROG_CLI_OFFER_CONFIG="false"
$ENV:CI="true"
jfrog rt download "$base_url/sxs/sxs2022.zip" "$artifactory_download_path\sxs2022.zip" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=https://ncr.jfrog.io/artifactory --threads=6 --flat=true
Expand-Archive "$artifactory_download_path\sxs2022.zip" -DestinationPath "$artifactory_download_path"
$sxs = "$artifactory_download_path\sxs"
Import-Module ServerManager;

####################################################
# Windows Features                                 #
####################################################

$NETFramework = @(
"NET-Framework-Features"
"NET-Framework-Core"
)

foreach ($NET in $NETFramework ){
Install-WindowsFeature -Name $NET -Source "$sxs"
}
$features = @(
"FileAndStorage-Services"
"Storage-Services"
"Web-Server"
"Web-WebServer"
"Web-Common-Http"
"Web-Default-Doc"
"Web-Dir-Browsing"
"Web-Http-Errors"
"Web-Static-Content"
"Web-Health"
"Web-Http-Logging"
"Web-Custom-Logging"
"Web-Log-Libraries"
"Web-Request-Monitor"
"Web-Performance"
"Web-Stat-Compression"
"Web-Security"
"Web-Filtering"
"Web-Basic-Auth"
"Web-Digest-Auth"
"Web-Windows-Auth"
"Web-App-Dev"
"Web-Net-Ext"
"Web-Net-Ext45"
"Web-AppInit"
"Web-ASP"
"Web-Asp-Net"
"Web-Asp-Net45"
"Web-CGI"
"Web-ISAPI-Ext"
"Web-ISAPI-Filter"
"Web-Mgmt-Tools"
"Web-Mgmt-Console"
"Web-Mgmt-Compat"
"Web-Metabase"
"Web-Lgcy-Mgmt-Console"
"Web-Lgcy-Scripting"
"Web-WMI"
"Web-Scripting-Tools"
"Web-Mgmt-Service"
"NET-Framework-45-ASPNET"
"Web-WHC"
"MSMQ"
"Telnet-Client"
)
foreach ($f in $features){
Install-WindowsFeature -Name $f 
}
}catch{
    $ErrorMessage = $_.Exception.Message
    write-error $ErrorMessage
    exit 1
    Break
}    


# erlang


try {
   
   # download
   $download_url =  "$artifactory_type/Erlang/otp_win64_23.2.exe"
   
   $ENV:JFROG_CLI_OFFER_CONFIG="false"
   $ENV:CI="true"
   jfrog rt download "$download_url" "$artifactory_download_path" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=$jfrog_base_url --threads=6 --flat=true
   write-output "ARTIFACTORY DOWNLOAD URL: $download_url"
   write-output "ARTIFACTORY DOWNLOAD PATH: $artifactory_download_path"

   # install
   Write-Verbose "### Installing prerequisites: otp_win64_23.2.exe ###" -Verbose
    $file = "$artifactory_download_path\otp_win64_23.2.exe"
    Invoke-Expression -Command "$file /S" -Verbose -ErrorAction Stop
    $x = 0
    do {
    Write-Verbose "checking if otp_win64_23.2.exe installation is done .." -Verbose
    $x++
    Start-Sleep -Seconds 40
      }
    until ((Test-Path HKLM:\SOFTWARE\WOW6432Node\Ericsson\Erlang) -eq 'True' -or $x -gt '2' )
    if ((Test-Path HKLM:\SOFTWARE\WOW6432Node\Ericsson\Erlang) -eq 'True')
       { Write-Verbose "otp_win64_23.2.exe installation complete !" -Verbose }

   # clean file
    remove-Item "$artifactory_download_path\otp_win64_23.2.exe" -force -confirm:$false -Verbose


}catch{
    $ErrorMessage = $_.Exception.Message
    write-error $ErrorMessage
    exit 1
    Break
}    

# rabbitmq

try {
   
   # download
   $download_url =  "$artifactory_type/Rabbitmq/3.8.9/rabbitmq-server-windows-3.8.9.zip"
   
   $ENV:JFROG_CLI_OFFER_CONFIG="false"
   $ENV:CI="true"
   jfrog rt download "$download_url" "$artifactory_download_path" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=$jfrog_base_url --threads=6 --flat=true
   write-output "ARTIFACTORY DOWNLOAD URL: $download_url"
   write-output "ARTIFACTORY DOWNLOAD PATH: $artifactory_download_path"

   # install
   Write-Verbose "### Installing prerequisites: rabbitmq-server-windows-3.8.9.zip ###" -Verbose
   
    Expand-Archive "$artifactory_download_path\rabbitmq-server-windows-3.8.9.zip" -DestinationPath "C:\Program Files\RabbitMQ Server"

    $erl = (Get-ChildItem -Path "C:\Program Files\erl*").FullName  
    [Environment]::SetEnvironmentVariable("ERLANG_HOME", $erl , "Machine")
       
       
    $rabbitdir = 'C:\RabbitMQ'
    mkdir $rabbitdir -Force
    [Environment]::SetEnvironmentVariable("RABBITMQ_BASE", $rabbitdir, "Machine")
    
    "[rabbitmq_management]." | Add-Content -PassThru "$rabbitdir\enabled_plugins" -Verbose
    '[ { rabbit, [	{ loopback_users, [ ] },	{ tcp_listeners, [ 5672 ] },	{ ssl_listeners, [ ] },	{ default_pass, <<"rabbit">> },	{ default_user, <<"rabbit">> },	{ hipe_compile, false }] } ].' | Add-Content -PassThru "$rabbitdir\rabbitmq.config" -Verbose
       
   # clean file
    remove-Item "$artifactory_download_path\rabbitmq-server-windows-3.8.9.zip" -force -confirm:$false -Verbose

    $sbin = (Get-ChildItem -Path "C:\Program Files\RabbitMQ Server\rabbitmq_server-*\sbin").FullName
    & $Sbin\rabbitmq-service.bat install
    & $Sbin\rabbitmq-service.bat start

}catch{
    $ErrorMessage = $_.Exception.Message
    write-error $ErrorMessage
    exit 1
    Break
}    

# MSDTC

try {
   
    [string]$MSDTCSecurity="HKLM:\Software\Microsoft\MSDTC\Security"
    [string]$MSDTC="HKLM:\Software\Microsoft\MSDTC" 
    Stop-Service MSDTC 
    sleep -Seconds 10
    Set-Service MSDTC -StartupType Automatic -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccess -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccessInbound -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccessOutbound -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccessAdmin -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccessClients -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccessTip -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name NetworkDtcAccessTransactions -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name XaTransactions -Value 0
    Set-ItemProperty -Path $MSDTCSecurity -Name LuTransactions -Value 1
    Set-ItemProperty -Path $MSDTCSecurity -Name AccountName -Value "NT AUTHORITYNetworkService"
    $A=@(
    "FallbackToUnsecureRPCIfNecessary"
    "TurnOffRpcSecurity"
    "AllowOnlySecureRpcCalls"
    )
    if ({$MSDTC -ccontains $A}) {
    sleep -Seconds 10
    set-ItemProperty -path $MSDTC -name "FallbackToUnsecureRPCIfNecessary" -Value 0
    set-ItemProperty -path $MSDTC -name "TurnOffRpcSecurity" -Value 1
    set-ItemProperty -Path $MSDTC  -Name "AllowOnlySecureRpcCalls" -Value 0
    }
    else {
    New-ItemProperty -path $MSDTC -name "FallbackToUnsecureRPCIfNecessary" -Value 0
    New-ItemProperty -path $MSDTC -name "TurnOffRpcSecurity" -Value 1
    New-ItemProperty -Path $MSDTC  -Name "AllowOnlySecureRpcCalls" -Value 0
    }
    sleep -Seconds 20
    Start-Service MSDTC
 
 }catch{
     $ErrorMessage = $_.Exception.Message
     write-error $ErrorMessage
     exit 1
     Break
 }    

 # fsharp

try {
   
   # download
   $download_url =  "$artifactory_type/F#RunTime/fsharp_redist.exe"
   $ENV:JFROG_CLI_OFFER_CONFIG="false"
   $ENV:CI="true"
   jfrog rt download "$download_url" "$artifactory_download_path" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=$jfrog_base_url --threads=6 --flat=true
   write-output "ARTIFACTORY DOWNLOAD URL: $download_url"
   write-output "ARTIFACTORY DOWNLOAD PATH: $artifactory_download_path"

   # install
    Write-Verbose "### Installing prerequisites: fsharp_redist.exe ###" -Verbose
    $file = "$artifactory_download_path\fsharp_redist.exe"
    Invoke-Expression -Command "$file /q" -Verbose
    $x = 0
    do {
    Write-Verbose "checking if fsharp_redist.exe installation is done .." -Verbose
    $x++
    Start-Sleep -Seconds 40
      }
    until ( ( (Test-Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\FSharp\2.0) -eq 'True' ) -or ( $x -gt '5' ) )
    if ( (Test-Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\FSharp\2.0) -eq 'True')
      { Write-Verbose "fsharp_redist.exe installation complete !" -Verbose }

   # clean files
    remove-Item "$artifactory_download_path\fsharp_redist.exe" -force -confirm:$false -Verbose

}catch{
    $ErrorMessage = $_.Exception.Message
    write-error $ErrorMessage
    exit 1
    Break
}    

# solver

try {
   
   # download
   $download_url =  "$artifactory_type/v/solverx64.msi"
   $ENV:JFROG_CLI_OFFER_CONFIG="false"
   $ENV:CI="true"
   jfrog rt download "$download_url" "$artifactory_download_path\solverx64.msi" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=$jfrog_base_url --threads=6 --flat=true
   write-output "ARTIFACTORY DOWNLOAD URL: $download_url"
   write-output "ARTIFACTORY DOWNLOAD PATH: $artifactory_download_path"

   # install
   Write-Verbose "### Installing prerequisites: solverx64.msi ###" -Verbose
    $file = "$artifactory_download_path\solverx64.msi"
    $install = start-process C:\Windows\System32\msiexec.exe -ArgumentList "/i $file /qn /norestart"  -Wait -PassThru
    Write-Verbose "agentransack installation ExitCode: $($install.ExitCode)" -Verbose
    if ($($install.ExitCode) -ne 0) { throw $($install.ExitCode) } else { write-output $($install.ExitCode) }
    
   # clean file
    remove-Item "$artifactory_download_path\solverx64.msi" -force -confirm:$false -Verbose
}catch{
    $ErrorMessage = $_.Exception.Message
    write-error $ErrorMessage
    exit 1
    Break
}    

# sql-2019-enterprise

Write-Verbose "Copy prerequisites: SQL 2019 enterprise" -Verbose

    try {

        $ENV:JFROG_CLI_OFFER_CONFIG="false"
        $ENV:CI="true"
        jfrog rt download "$base_url/Microsoft_SQL_2019/enterprise/en_sql_server_2019_enterprise_x64_dvd_5e1ecc6b.iso" "$artifactory_download_path\en_sql_server_2019_enterprise_x64_dvd_5e1ecc6b.iso" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=https://ncr.jfrog.io/artifactory --threads=6 --flat=true
        jfrog rt download "$base_url/Microsoft_SQL_2019/enterprise/ConfigurationFile.ini" "$artifactory_download_path\ConfigurationFile.ini" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=https://ncr.jfrog.io/artifactory --threads=6 --flat=true
        jfrog rt download "$base_url/Microsoft_SQL_2019/SSMS-Setup-ENU.exe" "$artifactory_download_path\SSMS-Setup-ENU.exe" --sort-by=created --sort-order=desc --limit=1 --user=$jfrog_user --password=$jfrog_api_key --url=https://ncr.jfrog.io/artifactory --threads=6 --flat=true


        # start sql installation
        Mount-DiskImage -ImagePath "$artifactory_download_path\en_sql_server_2019_enterprise_x64_dvd_5e1ecc6b.iso"
        $DriveLetter = (Get-Volume  | Where-Object {$_.FileSystemLabel -like "*SQL*"}).DriveLetter
        $DriveLetter = $DriveLetter+':'

        $ConfigurationFile = "$artifactory_download_path\ConfigurationFile.ini"
        Write-Verbose "Installing prerequisites: sql 2019 enterprise" -Verbose
        $sqlargs = "/IAcceptSQLServerLicenseTerms /ConfigurationFile=$($ConfigurationFile)"
        Invoke-Expression -Command "$DriveLetter\setup.exe $sqlargs" -Verbose -ErrorAction Stop
        Write-Verbose "installation complete for sql 2019 enterprise !" -Verbose
        
        # dismount iso
        Write-Verbose "Dismount ISO sql 2019 enterprise" -Verbose
        Dismount-DiskImage -ImagePath "$artifactory_download_path\en_sql_server_2019_enterprise_x64_dvd_5e1ecc6b.iso"

        #install sql-2019-SSMS
        Write-Verbose "Installing prerequisites: SSMS 2019" -Verbose
        Start-Process D:\SSMS-Setup-ENU.exe -ArgumentList "/quiet /install /norestart" -Wait -Verbose -ErrorAction Stop
        Write-Verbose (Test-Path "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Ssms.exe") -Verbose 

   } catch {
      Write-Error $_
      exit 1
   }


# sql-server-2019-cumulative

choco install sql-server-2019-cumulative-update -y --no-progress