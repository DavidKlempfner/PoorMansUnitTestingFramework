<#
.SYNOPSIS
This test module contains functions to assist in unit testing.
 
.DESCRIPTION
This test module contains functions to assist in unit testing.
 
.INPUTS
 
.OUTPUTS
 
.EXAMPLE
 
.NOTES
Author: dklempfner@gmail.com
Date: 08/12/2016
#>
 
 
function ExecuteTests
{
<#
.SYNOPSIS 
Executes all functions in $FilePath
 
.EXAMPLE
ExecuteTests $MyInvocation.MyCommand.Path
#>
    param([Parameter(Mandatory=$true)][String]$FilePath)
 
    [ref]$tokens      = $null
    [ref]$parseErrors = $null
    $ast = [Management.Automation.Language.Parser]::ParseFile($FilePath, $tokens, $parseErrors)
    $testFunctionIndicator = 'Test_'
    $testFunctions = $ast.EndBlock.Statements | Where-Object { $_.Name -and $_.Name.Substring(0, $testFunctionIndicator.Length) -eq $testFunctionIndicator }   
    $testFunctions | ForEach-Object { & $_.Name }
}
 
function OutputTestResult
{
    param([Parameter(Mandatory=$true)][Bool]$DidTestPass,
           [Parameter(Mandatory=$true)][String]$TestName)
 
    if($DidTestPass)
    {
        Write-Verbose "$TestName Passed"
    }
    else
    {
        Write-Warning "$TestName Failed"
    }
}