<#
.SYNOPSIS
    This script contains tests for the functions in GetDhcpScopeOptionValue.ps1
 
.DESCRIPTION
    This script contains tests for the functions in GetDhcpScopeOptionValue.ps1
 
.INPUTS
 
.OUTPUTS
 
.EXAMPLE
 
.NOTES
    Author: dklempfner@gmail.com
    Date: 23/01/2017
#>
 
Import-Module '.\TestModule.psm1'
 
. ..\GetDhcpScopeOptionValue.ps1 #This is the ps1 file with the functions you want to test.
 
### GetValueFromOptionId ###
$netshOutputWithNoBootp = '',
                    'Changed the current scope context to 11.196.34.64 scope.',
                    '',
                    'Options for the Reservation Address 11.196.34.69 in the Scope 11.196.34.64 :',
                    '',
                    '      DHCP Standard Options :',
                    '      General Option Values:',
                    '      OptionId : 15 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = STRING',
                    '             Option Element Value = abcdef',
                    '      OptionId : 60 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = STRING',
                    '             Option Element Value = zyxws',
                    '      OptionId : 6 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 2',
                    '             Option Element Type = IPADDRESS',
                    '             Option Element Value = 11.221.74.11',
                    '             Option Element Value = 11.221.76.34',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 214400',
                    'Command completed successfully.'
 
$netshOutputWithDhcpStandardOptionsAndBootpFirst = '',
                    'Changed the current scope context to 11.11.111.0 scope.',
                    '',
                    'Options for Scope 11.11.111.0:',
                    '',
                    '      For user class [Default BOOTP Class]:',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 691200',
                    '      DHCP Standard Options : ',
                    '      OptionId : 3 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = IPADDRESS',
                    '             Option Element Value = 11.11.111.1',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 214400',
                    '      OptionId : 66 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = STRING',
                    '             Option Element Value = SomeVal',
                    '      OptionId : 67 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = STRING',
                    '             Option Element Value = pathHere',
                    'Command completed successfully.'
 
$netshOutputWithVendorClassAndBootpLast = '',
                    'Changed the current scope context to 11.13.32.0 scope.',
                    '',
                    'Options for Scope 11.13.32.0:',
                    '',
                    '      For vendor class [Microsoft Options]:',
                    '      OptionId : 2 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 1',
                    '      OptionId : 3 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = IPADDRESS',
                    '             Option Element Value = 11.13.32.1',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 691200',
                    '      OptionId : 60 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = STRING',
                    '             Option Element Value = sdlfkjsdf',
                    '      For user class [Default BOOTP Class]:',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 1728001',
                    'Command completed successfully.'
 
$netshOutputWithBootpFirst = '',
                    'Changed the current scope context to 11.13.32.0 scope.',
                    '',
                    'Options for Scope 11.13.32.0:',
                    '',
                    '      For user class [Default BOOTP Class]:',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 1728001',
                    '      For vendor class [Microsoft Options]:',
                    '      OptionId : 2 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 1',
                    '      OptionId : 3 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = IPADDRESS',
                    '             Option Element Value = 11.13.32.1',
                    '      OptionId : 51 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = DWORD',
                    '             Option Element Value = 691200',
                    '      OptionId : 60 ',
                    '      Option Value: ',
                    '             Number of Option Elements = 1',
                    '             Option Element Type = STRING',
                    '             Option Element Value = sdlfkjsdf',                   
                    'Command completed successfully.'
 
function Test_GivenNetshOutputWithNoBootp_WhenTheOptionId6ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '11.221.74.11', '11.221.76.34'
 
    #Act
    $optionId = '6'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithNoBootp
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivenNetshOutputWithNoBootp_WhenTheOptionId15ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = 'abcdef'
 
    #Act
    $optionId = '15'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithNoBootp
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivenNetshOutputWithNoBootp_WhenTheOptionId60ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = 'zyxws'
 
    #Act
    $optionId = '60'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithNoBootp
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivenNetshOutputWithNoBootp_WhenTheOptionId51ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '214400'
 
    #Act
    $optionId = '51'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithNoBootp
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivennetshOutputWithDhcpStandardOptionsAndBootpFirst_WhenTheOptionId51ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '214400'
 
    #Act
    $optionId = '51'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithDhcpStandardOptionsAndBootpFirst
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivennetshOutputWithVendorClassAndBootpLast_WhenTheNonBootpOptionId51ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '691200'
 
    #Act
    $optionId = '51'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithVendorClassAndBootpLast
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivennetshOutputWithVendorClassAndBootpLast_WhenTheBootpOptionId51ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '1728001'
 
    #Act
    $optionId = '51'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithVendorClassAndBootpLast $true
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivennetshOutputWithVendorClassAndBootpLast_WhenTheNonBootpOptionId51ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '691200'
 
    #Act
    $optionId = '51'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithVendorClassAndBootpLast
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
function Test_GivennetshOutputWithVendorClassAndBootpLast_WhenTheBootpOptionId51ValueIsExtracted_AssertThatItsCorrect
{
    #Arrange   
    $expectedValues = '1728001'
 
    #Act
    $optionId = '51'
    $actualValues = GetValueFromOptionId $optionId $netshOutputWithVendorClassAndBootpLast $true
    $missingValues = Compare-Object $actualValues $expectedValues | Where-Object { $_.SideIndicator -eq "<=" }
 
    #Assert
    $didTestPass = $null -eq $missingValues
 
    OutputTestResult $didTestPass $MyInvocation.MyCommand
}
 
cls
 
$VerbosePreference = 'Continue'
$ErrorActionPreference = 'Stop'
 
ExecuteTests $MyInvocation.MyCommand.Path