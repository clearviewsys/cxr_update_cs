//%attributes = {}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/20/13, 10:02:21
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: strRemoveNonNumeric
// Description
// 
//
// Parameters
// ----------------------------------------------------





C_TEXT:C284($1; $xToBeStripped)
C_TEXT:C284($0; $xStripped)

$xToBeStripped:=$1
$xStripped:=""

//------------------------------------------------------------
//method_wide_constants_declarations
//------------------------------------------------------------
C_LONGINT:C283($iToBeStrippedLength)
C_LONGINT:C283($iCurrentSourceByte)
C_LONGINT:C283($iCurrentDestinationByte)
C_LONGINT:C283($iCurrentByteValue)
C_BOOLEAN:C305($qValidByteValue)
//============================================================
//init
$iCurrentDestinationByte:=0
$iToBeStrippedLength:=Length:C16($xToBeStripped)
//------------------------------------------------------------



//make sure there is text to loop through
If ($iToBeStrippedLength>0)
	//set initial length of resulting text
	$xStripped:="*"*$iToBeStrippedLength
	//loop through original text
	For ($iCurrentSourceByte; 1; $iToBeStrippedLength; 1)
		//get ASCII value of current source byte
		$iCurrentByteValue:=Character code:C91($xToBeStripped[[$iCurrentSourceByte]])
		
		//check value of current source byte
		If (($iCurrentByteValue>47) & ($iCurrentByteValue<58))  //number
			$qValidByteValue:=True:C214
		Else 
			$qValidByteValue:=False:C215
		End if 
		
		//make sure current source byte is valid
		If ($qValidByteValue)
			$iCurrentDestinationByte:=$iCurrentDestinationByte+1
			$xStripped[[$iCurrentDestinationByte]]:=Char:C90($iCurrentByteValue)
		End if 
	End for 
	
	//remove extras
	If ($iCurrentDestinationByte#$iToBeStrippedLength)
		$xStripped:=Substring:C12($xStripped; 1; $iCurrentDestinationByte)
	End if 
End if 


$0:=$xStripped