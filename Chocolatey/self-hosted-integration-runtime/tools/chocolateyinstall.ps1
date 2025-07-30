$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = ''
$checksum   = ''

$pp = Get-PackageParameters

if ([Version] (Get-CimInstance Win32_OperatingSystem).Version -lt [version] "10.0.0.0") {
  Write-Error "Microsoft Integration Runtime requires a minimum of Windows 10 or Windows Server 2016"
}


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'msi'
  url           = $url
  silentArgs    = "/quiet"
  validExitCodes= @(0, 3010, 1641)
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

# Register the integration runtime service if key is provided
if ($pp -and $pp['key']) {
  # Enable remote access and register the node with the provided key
  $DmgcmdPath = "C:\Program Files\Microsoft Integration Runtime\5.0\Shared\dmgcmd.exe"
  $NODE_NAME = $Env:COMPUTERNAME
  $AUTH_KEY= $($pp['key'])
  $PORT = "8060"
  Start-Process $DmgcmdPath -Wait -ArgumentList "-EnableRemoteAccessInContainer", "$($PORT)"
  Start-Process $DmgcmdPath -Wait -ArgumentList "-RegisterNewNode", "$($AUTH_KEY)", "$($NODE_NAME)" 
}