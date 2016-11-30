<#
.NOTES
* SecureString is a data type for securely storing strings in an encrypted form.
* Often string objects contain sensitive data such as a password. String objects contain an array of characters in memory, and 
if some unsafe or unmanaged code is allowed to execute, the unsafe/unmanaged code could snoop around the process’s address space, 
locate the string containing the sensitive information, and use this data in an unauthorized way.
* The users profile that creates the SecureString is used as a salt implicitly
#>

<#
.DESCRIPTION
Creating A SecureString - No Salt
#>

Read-Host -AsSecureString 'Enter a secret password' | ConvertFrom-SecureString

<#
.DESCRIPTION
Creating A SecureString - Explicit Salt
.NOTES
The specified key must be either 128 bits, 192 bits, or 256 bits in length
#>

$Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)
Read-Host -AsSecureString 'Enter a secret password' | ConvertFrom-SecureString -Key $Key

<#
.DESCRIPTION
Converting A SecureString To Plain Text - Explicit Salt
.NOTES
* This is a unique feature fo PowerShell that .NET cannot do. If you disassemble the ConvertToSecureStringCommand 
class (found in Microsoft.PowerShell.Security.dll in the GAC), you will find that it calls into an internal, helper 
class called SecureStringHelper. That class has a Decrypt method, which Base64 decodes the input and then uses 
standard .NET crypto functions to decrypt the original string (specifically, it uses AES). You would have to duplicate 
this functionality if you want to mimic ConvertTo-SecureString in C#. This implementation does however commit a cardinal 
sin that you should be aware of. ConvertTo-SecureString and ConvertFrom-SecureString put the unencrypted string 
into the manged heap (in the form of an array). As if someone could execute some unmanaged code whilst the PowerShell 
process is running and poke around the memory they could find the string in its clear text form.


#>

$Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)
$EncryptedString = '76492d1116743f0423413b16050a5345MgB8AHIANgBkAFAAWAArAFAAVAA3AFYAVgB6AHMAcgBDAEgAcQBMAFAASQBqAHcAPQA9AHwAZAAyADkAZgBiADAAZgA2ADIAOAA1AGEANQA2ADYAMgBjAGUAMQBiADcAMgA4ADYAYQA3ADQAYgA1AGMAMwBiADYAZgAwAGIAYgBlADMAMQBhADIANwBmAGEANQBjADIAZgA4ADgAMABlADYAMwBmADUANgBiADAANwBjADkAZgA='

$SecureStringObject = $EncryptedString | ConvertTo-SecureString -Key $Key
$Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($SecureStringObject)
[System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)