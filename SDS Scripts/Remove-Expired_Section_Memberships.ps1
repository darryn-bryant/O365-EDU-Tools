<#
Script Name:
Remove-Expired_Section_Memberships.ps1

Synopsis:
This script is designed to get all SDS classes that have been marked Expired, and remove their members. All Expired classes and removals are displayed on screen.

Syntax Examples and Options:
.\Remove-Expired_Section_Memberships.ps1

Written By: 
Bill Sluss

Change Log:
Version 1.0, 8/08/206 - First Draft
#>

$Groups = Get-AzureADGroup -All:$true | ? {$_.DisplayName –like “Exp*”}
$Count = $Groups.count
Write-host –ForegroundColor Green “Found $Count Classes Marked Expired. Starting Cleanup - Remove Members”

Foreach ($Group in $Groups) {
$Obj = $Group.objectID
$DN = $Group.DisplayName
Write-host –ForegroundColor Red “Removing Members of $DN”
$Members = Get-AzureADGroupMember -ObjectID $Obj

	Foreach ($Member in $Members){
	$MemID = $Member.ObjectID
	$MemName = $member.DisplayName
	Write-host –ForegroundColor Green “Removing $MemName from $DN”
	Remove-AzureADGroupMember -MemberId $MemID -ObjectId $Obj
			}
 		}

#Export the output array to CSV
Write-host –ForegroundColor Green “Script Complete”