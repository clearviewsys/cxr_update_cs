//%attributes = {}
// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 10/10/06, 23:47:39
// ----------------------------------------------------
// Method: XT_Get_Root
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $sObjectRef)
C_TEXT:C284($0; $tRoot)

$sObjectRef:=$1
$tRoot:=""

DOM GET XML ELEMENT NAME:C730($sObjectRef; $tRoot)

If (OK=1)
	$tRoot:="/"+$tRoot+"/"
End if 

$0:=$tRoot