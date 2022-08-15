//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/31/16, 08:26:41
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: TM_Add2Stack
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $tMessage)
C_LONGINT:C283($3; $iStartLevel)


$ptrTable:=$1
$tMessage:=$2
$iStartLevel:=$3



If (Undefined:C82(atTransStack))  //8/31/16
	ARRAY TEXT:C222(atTransStack; 0)
	ARRAY LONGINT:C221(aiTransStack; 0)
	C_TEXT:C284(tTransStack)
End if 

//APPEND TO ARRAY(atTransStack;Table name($ptrTable))
APPEND TO ARRAY:C911(atTransStack; Table name:C256($ptrTable)+":"+$tMessage)
APPEND TO ARRAY:C911(aiTransStack; $iStartLevel)

tTransStack:=tTransStack+"||ADD|"+atTransStack{Size of array:C274(atTransStack)}+"L"+String:C10(aiTransStack{Size of array:C274(aiTransStack)})+Char:C90(Carriage return:K15:38)