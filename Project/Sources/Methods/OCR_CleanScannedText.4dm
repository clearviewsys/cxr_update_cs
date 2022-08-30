//%attributes = {}
// OCR_CleanScannedText (->arrText )
// Clean Texts 
// TODO: Fix Objects

C_POINTER:C301($1; $arrTextPtr)
C_LONGINT:C283($i)
Case of 
		
	: (Count parameters:C259=1)
		$arrTextPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

For ($i; 1; Size of array:C274($arrTextPtr->))
	If (Length:C16($arrTextPtr->{$i})=1)
		$arrTextPtr->{$i}:=Uppercase:C13($arrTextPtr->{$i})
	End if 
End for 
