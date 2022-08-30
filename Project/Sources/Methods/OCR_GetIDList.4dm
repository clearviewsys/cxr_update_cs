//%attributes = {}
// OCR_GetIDList (->arrIDCodes; ->arrIDNames)
// Get a list of all IDs defined in OCR Component

C_POINTER:C301($1; $arrIDCodesPtr; $2; $arrIDNamesPtr)

Case of 
		
	: (Count parameters:C259=2)
		
		$arrIDCodesPtr:=$1
		$arrIDNamesPtr:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

allRecordsOCR_Ids
orderByOCR_Ids
SELECTION TO ARRAY:C260([OCR_Ids:109]Code:2; $arrIDCodesPtr->; [OCR_Ids:109]Name:3; $arrIDNamesPtr->)
