//%attributes = {}
C_TEXT:C284($0; $xStripped)
$xStripped:=""
C_TEXT:C284($1; $xToBeStripped)
$xToBeStripped:=$1
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
		Case of 
			: (($iCurrentByteValue>96) & ($iCurrentByteValue<123))  //lowercase letter
				$qValidByteValue:=True:C214
			: (($iCurrentByteValue>64) & ($iCurrentByteValue<91))  //uppercase letter
				$qValidByteValue:=True:C214
			: (($iCurrentByteValue>47) & ($iCurrentByteValue<58))  //number
				$qValidByteValue:=True:C214
			: (($iCurrentByteValue>33) & ($iCurrentByteValue<48))  //PUNCTUATION
				$qValidByteValue:=True:C214
			: (($iCurrentByteValue>57) & ($iCurrentByteValue<65))  //PUNCTUATION
				$qValidByteValue:=True:C214
			: (($iCurrentByteValue>90) & ($iCurrentByteValue<97))  //PUNCTUATION
				$qValidByteValue:=True:C214
			Else 
				$qValidByteValue:=False:C215
		End case 
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
//
//set return value
$0:=$xStripped
//eof