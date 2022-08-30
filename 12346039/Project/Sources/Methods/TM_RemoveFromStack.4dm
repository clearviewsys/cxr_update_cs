//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/31/16, 08:30:44
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: TM_RemoveFromStack
// Description
// 
//
// Parameters
// ----------------------------------------------------



//C_POINTER($1;$ptrTable)


C_LONGINT:C283($iSize)

If (Undefined:C82(atTransStack))  //8/31/16
	ARRAY TEXT:C222(atTransStack; 0)
	ARRAY LONGINT:C221(aiTransStack; 0)
End if 

$iSize:=Size of array:C274(atTransStack)
If ($iSize>0)
	tTransStack:=tTransStack+"||DEL|"+atTransStack{Size of array:C274(atTransStack)}+"L"+String:C10(Transaction level:C961)+Char:C90(Carriage return:K15:38)
	
	DELETE FROM ARRAY:C228(atTransStack; $iSize)  //delete last item
	DELETE FROM ARRAY:C228(aiTransStack; $iSize)
End if 