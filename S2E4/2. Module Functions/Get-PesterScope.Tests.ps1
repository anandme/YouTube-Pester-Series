$here = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$sut = $sut -replace 'ps1', 'psm1'
Import-Module -Name "$here\$sut" -Scope Local -Force

Get-Command -Module $sut.TrimEnd('.psm1')

Describe "Get-Module Scope" {
 
    InModuleScope -ModuleName $sut.TrimEnd('.psm1') {

        It "Tests Show-PublicFuction" {

            Show-PublicFuction 'TestMe' | Should -Be "Public Function TestMe"

        }

        It "Tests Show-PrivateFuction" {

            Show-PrivateFuction 'TestMe' | Should -Be "Private Function TestMe"
            
        }
        
    }
}