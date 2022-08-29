//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 09/17/18, 12:19:08
// ----------------------------------------------------
// Method: CXR_getSetting
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tSetting)
C_TEXT:C284($2; $tRef)

C_TEXT:C284($0; $tValue)

$tSetting:=$1

//TRACE

If (Count parameters:C259>=2)
	$tRef:=$1
Else 
	$tRef:=CXR_openConfigRef
End if 

$tValue:=""

If ($tRef="")
Else 
	XT_Get_Value($tRef; $tSetting; ->$tValue)
End if 

If ($tValue="")
	//DOM EXPORT TO VAR($tRef;$tValue)
	$0:=$tValue
Else 
	$0:=$tValue
End if 


If (Count parameters:C259<2)
	CXR_closeConfigRef($tRef)
End if 