//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/03/16, 14:47:34
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: strRemoveSpaces
// Description
// 
//     removes leading and trailing spaces from text
//
// Parameters
// ----------------------------------------------------




C_TEXT:C284($1; $tTheText)

C_TEXT:C284($0)
C_LONGINT:C283($iLength; $i)


$tTheText:=$1

If (True:C214)
	$tTheText:=Split string:C1554($tTheText; " ").join(" "; ck ignore null or empty:K85:5)
Else 
	$iLength:=Length:C16($tTheText)
	
	If ($iLength>0)
		
		For ($i; 1; $iLength)  //start by removing the leading spaces
			If (Substring:C12($tTheText; 1; 1)=Char:C90(Space:K15:42))
				$tTheText:=Substring:C12($tTheText; 2; $iLength)
			Else 
				$i:=$iLength
			End if 
		End for 
		
		
		For ($i; $iLength; 1; -1)  //remove the trailing spaces
			If (Substring:C12($tTheText; Length:C16($tTheText); 1)=Char:C90(Space:K15:42))
				$tTheText:=Substring:C12($tTheText; 1; Length:C16($tTheText)-1)
			Else 
				$i:=0
			End if 
		End for 
		
	End if 
End if 

$0:=$tTheText