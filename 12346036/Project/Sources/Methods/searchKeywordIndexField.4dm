//%attributes = {}
// searchKeywordIndexField (fieldPtr;searchPhrase)
// a quick search for  based on the tokenizer method

C_POINTER:C301($tablePtr; $fieldPtr; $1)
C_TEXT:C284($searchPhrase; vSearchString; $2)

Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		$searchPhrase:=vSearchString
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$searchPhrase:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tablePtr:=getTablePtrFromFieldPtr($fieldPtr)

READ ONLY:C145($tablePtr->)
C_TEXT:C284($request; $token)
ARRAY TEXT:C222($arrTokens; 0)
C_LONGINT:C283($i; $n)

tokenizePhraseIntoWords($searchPhrase; ->$arrTokens)
$n:=Size of array:C274($arrTokens)
ALL RECORDS:C47($tablePtr->)

For ($i; 1; $n)
	$token:=$arrTokens{$i}
	QUERY SELECTION:C341($tablePtr->; $fieldPtr->%$token+"@")
End for 

CLEAR VARIABLE:C89($arrTokens)