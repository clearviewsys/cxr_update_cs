//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 09/17/18, 12:31:25
// ----------------------------------------------------
// Method: CXR_setSetting
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tSetting)
C_TEXT:C284($2; $tValue)
C_TEXT:C284($3; $tRef)

C_LONGINT:C283($0; $iError)

$tSetting:=$1
$tValue:=$2

If (Count parameters:C259>=3)
	$tRef:=$3
Else 
	$tRef:=CXR_openConfigRef
End if 

$iError:=0

XT_Put_Value($tRef; $tSetting; ->$tValue)


If (Count parameters:C259<3)  //we had to open hte file so close it now
	CXR_closeConfigRef($tRef)
End if 

$0:=$iError

