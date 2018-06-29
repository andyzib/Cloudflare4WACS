Function Decrypt-CredXML {
<#
.SYNOPSIS
Decrypts the token stored in the Cloudflare XML Credfile.
 
.DESCRIPTION
Decrypts the token stored in the Cloudflare XML Credfile.

.PARAMETER CredFile
Full path to the XML Credential File. 

.OUTPUTS
Returns a hashtable with Email and Token properties. Token is a PowerShell Secure String. 

.NOTES
Created by: Andrew Zbikowski <andrew@itouthouse.com>
Revision History
2018-06-29: Initial Version
 
.EXAMPLE
Just run the script. 
#>
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        [string]$CredFile
    )
    #Import XML
    $MyCred = Import-CliXml -Path $CredFile

    # Decrypt Token
    $MyCred.Token = $MyCred.Token | ConvertTo-SecureString

    $Marshal = [System.Runtime.InteropServices.Marshal]

    $Bstr = $Marshal::SecureStringToBSTR($MyCred.Token)
    $MyCred.Token = $Marshal::PtrToStringAuto($Bstr)
    $Marshal::ZeroFreeBSTR($Bstr)

    # Return the decrypted hash table on the pipeline
    $MyCred
}