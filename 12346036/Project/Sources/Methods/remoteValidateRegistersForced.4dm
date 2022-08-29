//%attributes = {}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 11/22/20, 16:55:06
// ----------------------------------------------------
// Method: SYNC_forceValidateRegisters
// Description
//     for lotus TSB - runs validate that will force update bad HASH
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $param)  //remote site to validate against
C_OBJECT:C1216($0; $status)

$status:=New object:C1471

C_LONGINT:C283($iProcess)
C_TEXT:C284($tRemotePassword; $tRemoteSite; $tRemoteURL; $tSourceSite)


If (Count parameters:C259>=1)
	$param:=$1
Else 
	$param:=""
End if 

C_OBJECT:C1216($0; $status)

$status:=New object:C1471

If (SOAP Request:C783)
	$iProcess:=Execute on server:C373("remoteValidateRegistersForced"; 0; "remoteValidateRegistersForced")
	$status.success:=True:C214
	$status.statusText:="Validation Started"
Else 
	$status:=Sync_validateTable(Table:C252(->[Registers:10]); $param; True:C214; Add to date:C393(Current date:C33; 0; 0; -30); Current date:C33)
End if 


$0:=$status