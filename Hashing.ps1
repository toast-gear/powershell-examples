$Error.Clear()
Clear

<#

.LOGIC
Hashing mostly follows a similar pattern:

Input string -> Bytes -> Hash -> Base64
Input string + salt -> Bytes -> Hash -> Base64

How the salt is combined with the password does not have to be as simple as appending to the front or 
back of the word but it normally is. The reason for this is by adding a salt, ideally a unique salt per
account you defeat lookup tables, reverse lookup tables and rainbow tables. You don't need to get 
fancy as the salt as performed it's purpose.

#>

############ Configuration ############

$Passphrase = ''
$PassphraseSalt = ''
$EncrptionScheme = 'MD5'

#######################################

try
{
    [Reflection.Assembly]::LoadWithPartialName('System.Security.Cryptography')
}
catch
{

}
switch($EncrptionScheme)
{
    MD5
    {
        $PassphraseBytes = [system.Text.Encoding]::UTF8.GetBytes($Passphrase + $PassphraseSalt)
        $MD5 = New-Object System.Security.Cryptography.MD5CryptoServiceProvider
        $Hash = $MD5.ComputeHash($PassphraseBytes)
        [System.Convert]::ToBase64String($Hash)
    }
    SHA1
    {
        $PassphraseBytes = [system.Text.Encoding]::UTF8.GetBytes($Passphrase + $PassphraseSalt)
        $SHA1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
        $Hash = $SHA1.ComputeHash($PassphraseBytes)
        [System.Convert]::ToBase64String($Hash)
    }
    SHA256
    {
        $PassphraseBytes = [system.Text.Encoding]::UTF8.GetBytes($Passphrase + $PassphraseSalt)
        $SHA256 = New-Object System.Security.Cryptography.SHA256CryptoServiceProvider
        $Hash = $SHA256.ComputeHash($PassphraseBytes)
        [System.Convert]::ToBase64String($Hash)
    }
    SHA384
    {
        $PassphraseBytes = [system.Text.Encoding]::UTF8.GetBytes($Passphrase + $PassphraseSalt)
        $SHA384 = New-Object System.Security.Cryptography.SHA384CryptoServiceProvider
        $Hash = $SHA384.ComputeHash($PassphraseBytes)
        [System.Convert]::ToBase64String($Hash)
    }
    SHA512
    {
        $PassphraseBytes = [system.Text.Encoding]::UTF8.GetBytes($Passphrase + $PassphraseSalt)
        $SHA512 = New-Object System.Security.Cryptography.SHA512CryptoServiceProvider
        $Hash = $SHA512.ComputeHash($PassphraseBytes)
        [System.Convert]::ToBase64String($Hash)
    }
    Unicode
    {
        $SHA1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
        $PassphraseBytes = [system.Text.Encoding]::Unicode.GetBytes($Passphrase + $PassphraseSalt)
        [System.Convert]::ToBase64String($SHA1.ComputeHash($PassphraseBytes))
    }
}