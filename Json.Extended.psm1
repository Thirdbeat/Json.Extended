try
{
    Import-Module newtonsoft.json -ErrorAction Stop
}
catch
{
    Throw $_
    if($script:Admin )
}