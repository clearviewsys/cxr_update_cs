//%attributes = {}
// 10/10/2006 -- I. Barclay Berry
//Object Tools replacement using DOM XML object
// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 10/10/06, 23:47:55
// ----------------------------------------------------
// Method: XT_Is_Object
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $sObjectRef)

C_TEXT:C284($sName)

$sObjectRef:=$1

C_TEXT:C284($sCurrErrMethod)
$sCurrErrMethod:=Method called on error:C704  // Feb 9, 2012 11:40:13 -- I.Barclay Berry 

ON ERR CALL:C155("XT_On_Error")

//$sName:=DOM Get XML information($sObjectRef;SYSTEM ID )
DOM GET XML ELEMENT NAME:C730($sObjectRef; $sName)

//GET XML ERROR($sObjectRef;$tError) `this just crashes 4D
ON ERR CALL:C155($sCurrErrMethod)  // Feb 9, 2012 11:45:15 -- I.Barclay Berry 

If (OK=1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
