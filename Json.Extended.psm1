function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

Function Get-Newtonsoft.Json
{
    if(!(Test-Administrator))
    {
        Start-Process powershell -ArgumentList "-noexit","-Command  `"&{`Install-Package Newtonsoft.Json -Force`"}`"" -Verb runas -Wait
    }
    else
    {
        Install-Package Newtonsoft.Json -Force
    }
}

Function Get-Newtonsoft.Json.Schema
{
    if(!(Test-Administrator))
    {
        Start-Process powershell -ArgumentList "-noexit","-Command  `"&{`Install-Package Newtonsoft.Json.Schema`"}`"" -Verb runas -Wait
    }
    else
    {
        Install-Package Newtonsoft.Json.Schema -Force
    }
}

try
{
    Import-Module newtonsoft.json -ErrorAction Stop
    Write-Verbose "Newtonsoft.json Imported!"
}
catch
{
    Write-Error "Newtonsoft.json Is not installed on this system! Use 'Get-Newtonsoft.Json' to install"
    #Write-Error $_
}

try
{
    Import-Module Newtonsoft.Json.Schema -ErrorAction Stop
    Write-Verbose "Newtonsoft.Json.Schema Imported!"
}
catch
{
    Write-Error "Newtonsoft.Json.Schema Is not installed on this system! Use 'Get-Newtonsoft.Json.Schema' to install"
    #Write-Error $_
}