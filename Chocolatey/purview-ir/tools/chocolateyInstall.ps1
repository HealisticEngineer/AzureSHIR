$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = ''
$checksum   = ''
$softwareName = 'Microsoft Purview Integration Runtime *5.36.8726.3*'


if ([Version] (Get-CimInstance Win32_OperatingSystem).Version -lt [version] "10.0.0.0") {
  Write-Error "Microsoft Purview Integration Runtime requires a minimum of Windows 10 or Windows Server 2016"
}


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'msi'
  url           = $url
  silentArgs    = "/quiet"
  validExitCodes= @(0, 3010, 1641)
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs
