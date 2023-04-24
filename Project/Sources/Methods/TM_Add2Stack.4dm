//%attributes = {}

//// ----------------------------------------------------
//// User name (OS): Barclay Berry
//// Date and time: 08/31/16, 08:26:41
//// Copyright 2015 -- IBB Consulting, LLC
//// ----------------------------------------------------
//// Method: TM_Add2Stack
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------




//C_POINTER($1; $ptrTable)
//C_TEXT($2; $tMessage)
//C_LONGINT($3; $iStartLevel)

//$ptrTable:=$1
//$tMessage:=$2
//$iStartLevel:=$3

//C_TEXT(tTransStack)
//If (Undefined(atTransStack))  //8/31/16
//ARRAY TEXT(atTransStack; 0)
//ARRAY LONGINT(aiTransStack; 0)
//End if 

////APPEND TO ARRAY(atTransStack;Table name($ptrTable))
//APPEND TO ARRAY(atTransStack; Table name($ptrTable)+":"+$tMessage)
//APPEND TO ARRAY(aiTransStack; $iStartLevel)

//tTransStack:=tTransStack+"||ADD|"+atTransStack{Size of array(atTransStack)}+"L"+String(aiTransStack{Size of array(aiTransStack)})+Char(Carriage return)