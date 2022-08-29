//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/31/16, 08:35:39
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: TM_GetCurrentTable
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0)
C_LONGINT:C283($iSize)

If (Undefined:C82(atTransStack))  //8/31/16
	ARRAY TEXT:C222(atTransStack; 0)
	ARRAY LONGINT:C221(aiTransStack; 0)
	C_TEXT:C284(tTransStack)
End if 

$iSize:=Size of array:C274(atTransStack)
If ($iSize>0)
	//$0:=atTransStack{$iSize}+" Trans Level="+String(Transaction level)
	$0:=tTransStack
Else 
	//$0:="atTransStack size="+String($iSize)+" Trans Level="+String(Transaction level)
	$0:="||ERROR:L=0| "+tTransStack
End if 