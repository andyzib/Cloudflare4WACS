#requires -version 5
<#
.SYNOPSIS
Cloudflare DNS remove script for WACS. 
 
.DESCRIPTION
Cloudflare DNS remove script for WACS.
 
.PARAMETER Hostname
Hostname that's been validated.

.PARAMETER Name
Name of the TXT record to remove.
 
.INPUTS
Credential file saved at $PSRoot\Cloudflare.xml. Create file with Create-CFXMLCredFile.ps1.
 
.OUTPUTS
Powershell transcript written to $env:TEMP
 
.NOTES
Author:         Andrew Zbikowski <andrew@itouthouse.com>
Revision History
2018-06-29: Initial script development
 
.EXAMPLE
<Example goes here. Repeat this attribute for more than one example>
#>
 
#-------------[Parameters]-----------------------------------------------------
# Enable -Debug, -Verbose Parameters. Write-Debug and Write-Verbose!
[CmdletBinding()]

# WACS will call the provided script with three parameters, but not specificy paramenters. 
# Order of incoming parameters is important.  
Param (
    [Parameter(Mandatory=$true,Position=0)]
    [ValidateNotNullOrEmpty()]
    [string]$Hostname,
    [Parameter(Mandatory=$true,Position=1)]
    [ValidateNotNullOrEmpty()]
    [string]$Name
)

#-------------[Initializations]------------------------------------------------
 
#Set Error Action to Silently Continue
#$ErrorActionPreference = "SilentlyContinue"
Import-Module pscloudflare -ErrorAction Stop
 
#-------------[Declarations]---------------------------------------------------

# ISO 8601 Date Format. Accept no substitutes! 
$iso8601 = Get-Date -Format s
# Colon (:) isn't a valid character in file names.
$iso8601 = $iso8601.Replace(":","_")
# Transcript File
$TranscriptFile = $env:TEMP + '\' + $iso8601 + '_CFacmeCreateDNS.txt'
 
#-------------[Functions]------------------------------------------------------
. $PSRoot + '\Decrypt-CredXML.ps1' 
 
#-------------[Execution]------------------------------------------------------
 
Start-Transcript -Path $TranscriptFile
 
<# Pseudocode
 
Logic, flow, etc.

Connect-CFClientAPI [-APIToken] <String> [-EmailAddress] <String>
Get-CFZoneID -Zone 'contoso.com'
Get-CFDNSRecord [[-ZoneID] <String>] [[-ID] <String>] [[-RecordType] <CFDNSRecordType>] [[-Name] <String>] [[-PerPage] <Int32>] [[-Order] <String>] [[-Direction] <String>] [[-MatchScope] <String>]
Remove-CFDNSRecord [[-ZoneID] <String>] [-ID] <String>
End Pseudocode #>

# Import Credentials. 
$cfcred = Decrypt-CredXML

# Connect to CloudFlare
$cloudflare = Connect-CFClientAPI -APIToken $cfcred.Token -EmailAddress $cfcred.Email

# Get the ZoneID from the domain and TLD. 
$pattern = '^.*\.(.*\..*)$'
$DNSZone = $Hostname -split $pattern
$DNSZoneID = Get-CFZoneID -Zone $DNSZone

# Get the record. 
$result = Get-CFDNSRecord -ZoneID $DNSZoneID -RecordType TXT -Name $Name

$result2 = Remove-CFDNSRecord -ZoneID $DNSZoneID -ID $result.ID

Write-Host "Removed DNS Record:"
Write-Host "DNSZone: $DNSZone"
Write-Host "DNSZoneID: $DNSZoneID"
Write-Host "Record Name: $Name"
Write-Host "Hostname: $Hostname"
Write-Host "Get-CFDNSRecord Result:" 
$result
Write-Host "Remove-CFDNSRecord Result:"
$result2
Stop-Transcript
