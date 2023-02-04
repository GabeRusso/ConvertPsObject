$moduleName = 'Convert'
$function = $MyInvocation.MyCommand.Name.Split('.')[0]

$pathToManifest = [System.IO.Path]::Combine($PSScriptRoot, '..', '..', $moduleName, "$moduleName.psd1")
if (Get-Module -Name $moduleName -ErrorAction 'SilentlyContinue') {
    Remove-Module -Name $moduleName -Force
}
Import-Module $pathToManifest -Force

Describe -Name $function -Fixture {
    BeforeEach {
        $Base64String = 'VGhpc0lzTXlTdHJpbmc='
        $ExpectedString = 'ThisIsMyString'
        $ExpectedByteArray = @(
            84
            104
            105
            115
            73
            115
            77
            121
            83
            116
            114
            105
            110
            103
        )

        # Use the variables so IDe does not complain
        $null = $Base64String, $ExpectedString, $ExpectedByteArray
    }

    Context -Name "Default: <Encoding>" -ForEach @(
        @{
            Encoding = 'ASCII'
        }
        @{
            Encoding = 'BigEndianUnicode'
        }
        @{
            Encoding = 'Default'
        }
        @{
            Encoding = 'Unicode'
        }
        @{
            Encoding = 'UTF32'
        }
        @{
            Encoding = 'UTF7'
        }
        @{
            Encoding = 'UTF8'
        }
    ) -Fixture {
        It -Name "Converts a <Encoding> Encoded string to a ByteArray" -Test {
            $splat = @{
                Base64   = $Base64String
            }
            $assertion = ConvertFrom-Base64 @splat
            $assertion | Should -BeExactly $ExpectedByteArray
        }

        It -Name 'Supports the Pipeline' -Test {
            $assertion = $Base64String | ConvertFrom-Base64
            $assertion | Should -BeExactly $ExpectedByteArray
        }

        It -Name 'Supports EAP SilentlyContinue' -Test {
            $splat = @{
                Base64   = 'a'
            }
            $assertion = ConvertFrom-Base64 @splat -ErrorAction SilentlyContinue
            $assertion | Should -BeNullOrEmpty
        }

        It -Name 'Supports EAP Stop' -Test {
            $splat = @{
                Base64   = 'a'
            }
            { ConvertFrom-Base64 @splat -ErrorAction Stop } | Should -Throw
        }

        It -Name 'Supports EAP Continue' -Test {
            $splat = @{
                Base64   = 'a'
            }
            $assertion = ConvertFrom-Base64 @splat -ErrorAction Continue 2>&1

            $ExpectedList = @(
                'Invalid length for a Base-64 char array or string.',
                'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.'
            )

            $assertion.Exception.InnerException.Message | Should -BeIn $ExpectedList
        }
    }

    Context -Name "-ToString : <Encoding>" -ForEach @(
        @{
            Encoding = 'ASCII'
            Base64   = 'VGhpc0lzTXlTdHJpbmc='
        }
        @{
            Encoding = 'BigEndianUnicode'
            Base64   = 'AFQAaABpAHMASQBzAE0AeQBTAHQAcgBpAG4AZw=='
        }
        @{
            Encoding = 'Default'
            Base64   = 'VGhpc0lzTXlTdHJpbmc='
        }
        @{
            Encoding = 'Unicode'
            Base64   = 'VABoAGkAcwBJAHMATQB5AFMAdAByAGkAbgBnAA=='
        }
        @{
            Encoding = 'UTF32'
            Base64   = 'VAAAAGgAAABpAAAAcwAAAEkAAABzAAAATQAAAHkAAABTAAAAdAAAAHIAAABpAAAAbgAAAGcAAAA='
        }
        @{
            Encoding = 'UTF7'
            Base64   = 'VGhpc0lzTXlTdHJpbmc='
        }
        @{
            Encoding = 'UTF8'
            Base64   = 'VGhpc0lzTXlTdHJpbmc='
        }
    ) -Fixture {
        It -Name "Converts a <Encoding> Encoded string to a string" -Test {
            $splat = @{
                Base64   = $Base64
                Encoding = $Encoding
                ToString = $true
            }
            $assertion = ConvertFrom-Base64 @splat
            $assertion | Should -BeExactly $ExpectedString
        }

        It -Name 'Supports the Pipeline' -Test {
            $assertion = $Base64 | ConvertFrom-Base64 -Encoding $Encoding -ToString
            $assertion | Should -BeExactly $ExpectedString
        }

        It -Name 'Supports EAP SilentlyContinue' -Test {
            $splat = @{
                Base64   = 'a'
                Encoding = $Encoding
                ToString = $true
            }
            $assertion = ConvertFrom-Base64 @splat -ErrorAction SilentlyContinue
            $assertion | Should -BeNullOrEmpty
        }

        It -Name 'Supports EAP Stop' -Test {
            $splat = @{
                Base64   = 'a'
                Encoding = $Encoding
                ToString = $true
            }
            { ConvertFrom-Base64 @splat -ErrorAction Stop } | Should -Throw
        }

        It -Name 'Supports EAP Continue' -Test {
            $splat = @{
                Base64   = 'a'
                Encoding = $Encoding
                ToString = $true
            }
            $assertion = ConvertFrom-Base64 @splat -ErrorAction Continue 2>&1

            $ExpectedList = @(
                'Invalid length for a Base-64 char array or string.',
                'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.'
            )

            $assertion.Exception.InnerException.Message | Should -BeIn $ExpectedList
        }
    }
}
