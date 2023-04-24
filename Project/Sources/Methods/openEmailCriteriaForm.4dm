//%attributes = {}

// ----------------------------------------------------
// User name (OS): viktor
// Date and time: 06/05/21, 19:49:24
// ----------------------------------------------------
// Method: openEmailValidationCriteria
// Description
// Retrusn and object with the criteria that determines a valid email
//
// Parameters
// ----------------------------------------------------

var $formObj; $settingsObj; $0 : Object
C_LONGINT:C283($winRef)

$settingsObj:=New object:C1471()
$formObj:=New object:C1471()
$formObj.hitsLeft:=RAL2_getCurrentAvailableHits("CXW.EmailVer")

$winRef:=Open form window:C675("emailVerificationCriteriaSingle"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("emailVerificationCriteriaSingle"; $formObj)
CLOSE WINDOW:C154($winRef)

If (OB Is defined:C1231($formObj; "validCriteria"))
	$settingsObj.criteria:=$formObj.validCriteria
	$settingsObj.validate:=True:C214
Else 
	$settingsObj.validate:=False:C215
End if 

$0:=$settingsObj