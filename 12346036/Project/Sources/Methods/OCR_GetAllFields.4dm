//%attributes = {}
// OCR_GetAllFields 
// Get all ID defined for OCR

ARRAY LONGINT:C221(arrFieldID; 0)
ARRAY TEXT:C222(arrFieldCode; 0)
ARRAY TEXT:C222(arrFieldName; 0)
ARRAY TEXT:C222(arrFieldRegExp; 0)
ARRAY TEXT:C222($arrKeywords; 0)
ARRAY TEXT:C222($arrText; 0)
C_LONGINT:C283($i)
C_TEXT:C284($systemLang; $token)

Case of 
	: (Count parameters:C259=0)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get all defined ID into arrays
Begin SQL
	
	SELECT ID, fieldCode, keyword,  fieldRegExp
	FROM OCR_Fields
	ORDER BY keyword, fieldCode  ASC 
	INTO :arrFieldID, :arrFieldCode, :$arrKeywords, :arrFieldRegExp ;
	
End SQL

// Get Fields name using Keywords

For ($i; 1; Size of array:C274($arrKeywords))
	$token:=OCR_SplitAndLocalizeFieldName($arrKeywords{$i})
	APPEND TO ARRAY:C911(arrFieldName; $token)
End for 

// Sort all arrays by Name ASC
SORT ARRAY:C229(arrFieldName; arrFieldCode; arrFieldID; arrFieldRegExp)

arrFieldID:=0
arrFieldName:=0
arrFieldCode:=0
arrFieldName:=0
arrFieldRegExp:=0
arrFieldName{0}:="-- "+Uppercase:C13(getLocalizedKeyword("select"))+" --"
