<#
    .SYNOPSIS
        Converts a string to a byte array object.

    .DESCRIPTION
        Converts a string to a byte array object.

    .PARAMETER String
        A string object for conversion.

    .PARAMETER Encoding
        The encoding to use for conversion.
        Defaults to UTF8.
        Valid options are ASCII, BigEndianUnicode, Default, Unicode, UTF32, UTF7, and UTF8.

    .EXAMPLE
        $bytes = ConvertFrom-StringToByteArray -String 'A string'
        $bytes.GetType()

        IsPublic IsSerial Name                                     BaseType
        -------- -------- ----                                     --------
        True     True     Byte[]                                   System.Array

        $bytes[0].GetType()

        IsPublic IsSerial Name                                     BaseType
        -------- -------- ----                                     --------
        True     True     Byte                                     System.ValueType

    .EXAMPLE
        $bytes = 'A string','Another string' | ConvertFrom-StringToByteArray

        $bytes.Count
        2

        $bytes.GetType()

        IsPublic IsSerial Name                                     BaseType
        -------- -------- ----                                     --------
        True     True     Object[]                                 System.Array

        $bytes[0].GetType()

        IsPublic IsSerial Name                                     BaseType
        -------- -------- ----                                     --------
        True     True     Byte[]                                   System.Array

    .OUTPUTS
        [System.Collections.Generic.List[Byte[]]]

    .LINK
        http://convert.readthedocs.io/en/latest/functions/ConvertFrom-StringToByteArray/
#>
function ConvertFrom-StringToByteArray {
    [CmdletBinding(HelpUri = 'http://convert.readthedocs.io/en/latest/functions/ConvertFrom-StringToByteArray/')]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $String,

        [ValidateSet('ASCII', 'BigEndianUnicode', 'Default', 'Unicode', 'UTF32', 'UTF7', 'UTF8')]
        [String]
        $Encoding = 'UTF8'
    )

    begin {
        $userErrorActionPreference = $ErrorActionPreference
    }

    process {
        foreach ($s in $String) {
            # Creating a generic list to ensure an array of string being handed in
            # outputs an array of Byte arrays, rather than a single array with both
            # Byte arrays merged.
            $byteArrayObject = [System.Collections.Generic.List[Byte[]]]::new()
            try {
                $byteArray = [System.Text.Encoding]::$Encoding.GetBytes($s)
                $null = $byteArrayObject.Add($byteArray)
                $byteArrayObject
            } catch {
                Write-Error -ErrorRecord $_ -ErrorAction $userErrorActionPreference
            }
        }
    }
}