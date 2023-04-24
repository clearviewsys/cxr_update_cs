//%attributes = {}

//// ----------------------------------------------------
//// User name (OS): Barclay Berry
//// Date and time: 08/31/16, 08:30:44
//// Copyright 2015 -- IBB Consulting, LLC
//// ----------------------------------------------------
//// Method: TM_RemoveFromStack
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------



////C_POINTER($1;$ptrTable)

//C_LONGINT($iSize)
//C_TEXT(tTransStack)


//If (Undefined(atTransStack))  //8/31/16
//ARRAY TEXT(atTransStack; 0)
//ARRAY LONGINT(aiTransStack; 0)
//End if 

//$iSize:=Size of array(atTransStack)
//If ($iSize>0)
//tTransStack:=tTransStack+"||DEL|"+atTransStack{Size of array(atTransStack)}+"L"+String(Transaction level)+Char(Carriage return)

//DELETE FROM ARRAY(atTransStack; $iSize)  //delete last item
//DELETE FROM ARRAY(aiTransStack; $iSize)
//End if 