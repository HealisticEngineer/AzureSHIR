Import-Module chocolatey-au

function global:au_BeforeUpdate {
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_SearchReplace {
    @{
        #   softwareName  = 'Microsoft Purview Integration Runtime *5.36.8726.3*'
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]softwareName\s*=\s*)('.*')" = "`$1'Microsoft Purview Integration Runtime *$($Latest.version)*'"
        }
     }
}

function global:au_GetLatest {

    # download the page that contains the latest version number
    $url = "https://www.microsoft.com/en-us/download/details.aspx?id=105539"
    # regex expresion to find version number example 5.36.8726.3
    $regex = ([regex]"\d+\.\d+\.\d+\.\d+")
    # sort numbers and get highest number
    $version = (((Invoke-WebRequest $url -UseBasicParsing).RawContent | Select-String "$regex" -AllMatches ).Matches.Value | Sort-Object -Descending -Unique)[0] -split " " | Select-Object -Last 1
    # construct the download url for the latest version
    $URL64 = "https://download.microsoft.com/download/578967c7-91d7-4d35-bec2-0aff59ec74b5/IntegrationRuntime_$version.msi"

    $Latest = @{ 
        URL64 = $URL64
        Version = $version
    }

    return $Latest
}

update -ChecksumFor None -NoCheckChocoVersion