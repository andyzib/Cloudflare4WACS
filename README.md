# Cloudflare DNS-01 Provider for Windows ACME Simple
A set of scripts to perform the DNS-01 challenge using Cloudflare and WACS.

# Overview
[Windows ACME Simple (WACS)](https://github.com/PKISharp/win-acme) is a simple Let's Encrypt ACME client for Windows that has built in support for Azure DNS. I've very familar with WACS, but I use Cloudflare for my homelab DNS. I created these scripts to perform the DNS-01 challenge for Cloudflare.

# Requirments
Install-Module PSCloudflare

# Setup
Run Create-CFXMLCredFile.ps1 to create a XML file holding your encrypted Cloudflare credentials. 

# Running
Scripts should be called by the WACS client. 

letsenrypt.exe --validationmode dns-01 --validation dnsscript --dnscreatescript Cloudflare4WinAcme\Create-CFacmeDNS.ps1 --dnsdeletescript Cloudflare4WinAcme\Remove-CFacmeDNS.ps1

# Support
None offered. 

# WACS DNS Script Requirments
### Run external program/script to create and update records.
1. Create script should be provided that accepts three parameters.
  * Hostname that's being validated
  * Name of the TXT record to create
  * Content of the TXT record to create
2. Delete script should be provided that accepts two parameters.
  * Hostname that's being validated
  * Name of the TXT record to delete
3. Run with arguments: --validationmode dns-01 --dnscreatescript C:\create-dns.bat --dnsdeletescript C:\delete-dns.bat --validation dnsscript
