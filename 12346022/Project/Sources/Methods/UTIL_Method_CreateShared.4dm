//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 09/11/14, 21:24:09
// ----------------------------------------------------
// Method: UTIL_Method_CreateShared
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1)  //method name
C_TEXT:C284($2)  //code 

C_BOOLEAN:C305($3; $bShared)  //shared
C_BOOLEAN:C305($4; $bInvisible)  //invisible


If (Count parameters:C259>=3)
	$bShared:=$3
Else 
	$bShared:=False:C215
End if 

If (Count parameters:C259>=4)
	$bInvisible:=$4
Else 
	$bInvisible:=False:C215
End if 


METHOD SET CODE:C1194($1; $2; *)

If ($bShared)
	METHOD SET ATTRIBUTE:C1192($1; Attribute shared:K72:10; True:C214; *)
End if 

If ($bInvisible)
	METHOD SET ATTRIBUTE:C1192($1; Attribute invisible:K72:6; True:C214; *)
End if 