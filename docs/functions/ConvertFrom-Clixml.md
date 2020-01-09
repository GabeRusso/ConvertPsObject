---
external help file: Convert-help.xml
Module Name: Convert
online version: http://convert.readthedocs.io/en/latest/functions/ConvertFrom-Clixml/
schema: 2.0.0
---

# ConvertFrom-Clixml

## SYNOPSIS
Converts Clixml to an object.

## SYNTAX

```
ConvertFrom-Clixml [-String] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Converts Clixml to an object.

## EXAMPLES

### EXAMPLE 1
```
$xml = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
<S>ThisIsMyString</S>
</Objs>
"@
ConvertFrom-Clixml -String $xml
```

ThisIsMyString

### EXAMPLE 2
```
$xml = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
<S>ThisIsMyString</S>
</Objs>
"@
$xml | ConvertFrom-Clixml
```

ThisIsMyString

### EXAMPLE 3
```
$xml = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
<S>ThisIsMyString</S>
</Objs>
"@
$xml2 = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
<S>This is another string</S>
</Objs>
"@
ConvertFrom-Clixml -String $xml,$xml2
```

ThisIsMyString
This is another string

### EXAMPLE 4
```
$xml = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
<S>ThisIsMyString</S>
</Objs>
"@
$xml2 = @"
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
<S>This is another string</S>
</Objs>
"@
$xml,$xml2 | ConvertFrom-Clixml
```

ThisIsMyString
This is another string

## PARAMETERS

### -String
Clixml as a string object.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [Object[]]
## NOTES

## RELATED LINKS

[http://convert.readthedocs.io/en/latest/functions/ConvertFrom-Clixml/](http://convert.readthedocs.io/en/latest/functions/ConvertFrom-Clixml/)

