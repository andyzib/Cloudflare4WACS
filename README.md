# Cloudflare DNS-01 Provider for Windows ACME Simple
A set of scripts to perform the DNS-01 challenge using Cloudflare and WACS.

# Overview
[Windows ACME Simple (WACS)](https://github.com/PKISharp/win-acme) is a simple Let's Encrypt ACME client for Windows that has built in support for Azure DNS. I've very familar with WACS, but I use Cloudflare for my homelab DNS. I created these scripts to perform the DNS-01 challenge for Cloudflare.

# Requirments
Install-Module PSCloudflare

# Setup

# Running

# Settings

# Wiki

# Support

# WACS Requirments
Script

    Run external program/script to create and update records.
    One create script should be provided that accepts three parameters.
        Hostname that's being validated
        Name of the TXT record to create
        Content of the TXT record to create
    One delete script should be provided that accepts two parameters.
        Hostname that's being validated
        Name of the TXT record to delete
    Unattended --validationmode dns-01 --dnscreatescript C:\create-dns.bat --dnsdeletescript C:\delete-dns.bat --validation dnsscript
