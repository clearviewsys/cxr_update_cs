//%attributes = {}
// OCR_SplitFieldName ($field) -> i19n FieldNames

C_TEXT:C284($0; $1; $keyword; $token)
ARRAY TEXT:C222($arrText; 0)

Case of 
	: (Count parameters:C259=1)
		$keyword:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$token:=""
OCR_ExplodeString($keyword; "+"; ->$arrText)
C_LONGINT:C283($i)

For ($i; 1; Size of array:C274($arrText))
	If ($i>1)
		$token:=$token+"+"
	End if 
	$token:=$token+OCR_GetLocalizedKeyword($arrText{$i})
End for 

$0:=$token