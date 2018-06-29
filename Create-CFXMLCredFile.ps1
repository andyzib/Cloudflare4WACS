#requires -version 5
<#
.SYNOPSIS
Creates an XML file with the encrypted credentials needed to access Cloudflare API. 
 
.DESCRIPTION
Creates an XML file with the encrypted credentials needed to use Create-CFacmeDNS.ps1 and Remove-CFacmeDNS.ps1. 

.OUTPUTS
$PSScriptRoot\Cloudflare.xml

.NOTES
Created by: Andrew Zbikowski <andrew@itouthouse.com>
Revision History
2018-06-29: Initial Version
 
.EXAMPLE
Just run the script. 
#>


# This works and creates a single XML file. Yay. 
$OutFile = $PSScriptRoot + "\Cloudflare.xml"
@{
    'Email' = Read-Host -Prompt 'Please enter email address used to login to Cloudflare'
    #'Zone' = Read-Host -Prompt "Enter the DNS zone" |  ConvertFrom-SecureString # Should be able to get the DNS zone from incoming FQDN. 
    'Token'    = Read-Host -Prompt "Enter your Cloudflare API token" -AsSecureString |  ConvertFrom-SecureString 
} | Export-Clixml -Path $outfile