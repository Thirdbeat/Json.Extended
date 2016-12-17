$script:SchemaDLLPath = $(Get-ChildItem "$(Split-Path $PSScriptRoot -Parent)\DLL\Schema" -Filter '*.dll')
$script:JsonDLLPath = $(Get-ChildItem "$(Split-Path $PSScriptRoot -Parent)\DLL\Json" -Filter '*.dll')


Function Add-SchemaDll
{
    #$script:SchemaDLL = add-type -Path $script:SchemaDLLPath.FullName
    try
    {
        #$NewtonsoftJsonDllPath = Get-ChildItem (Get-Module newtonsoft.json).ModuleBase -Recurse -Filter *.dll
        #$asm = [Reflection.Assembly]::LoadFile("$PSScriptRoot\libs\Newtonsoft.Json.dll")
        $asm = [reflection.assembly]::LoadFrom($script:JsonDLLPath.FullName)
        Add-Type -Path $script:SchemaDLLPath.FullName -ReferencedAssemblies $script:JsonDLLPath.FullName
    }
    catch
    {
        $_.Exception.LoaderExceptions | %{Write-Error $_.Message}
    }
}

Function convertto-JSchema
{
    param(
        $inputobject
    )
    Add-SchemaDll
    #$inputobject
    #Write-Host "$([System.Type]::GetType($inputobject))"
    $JGenerator = [Newtonsoft.Json.Schema.Generation.JSchemaGenerator]::new()
    $jschema = $JGenerator.Generate($inputobject.gettype())
    $jschema
}

function New-JschemaObject
{
    
}

