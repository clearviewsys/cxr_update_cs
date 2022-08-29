//%attributes = {}
// OCR_GetLanguages (->array )
// Fills the array with all the OCR online Languages provided
C_POINTER:C301($1; $arrLangPtr)

Case of 
	: (Count parameters:C259=1)
		$arrLangPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

APPEND TO ARRAY:C911($arrLangPtr->; "English=eng")
APPEND TO ARRAY:C911($arrLangPtr->; "Chinese Simplified=chs")
APPEND TO ARRAY:C911($arrLangPtr->; "Chinese Traditional=cht")
APPEND TO ARRAY:C911($arrLangPtr->; "Danish=dan")
APPEND TO ARRAY:C911($arrLangPtr->; "Dutch=dut")
APPEND TO ARRAY:C911($arrLangPtr->; "Finnish=fin")
APPEND TO ARRAY:C911($arrLangPtr->; "French=fre")
APPEND TO ARRAY:C911($arrLangPtr->; "German=ger")
APPEND TO ARRAY:C911($arrLangPtr->; "Greek=gre")
APPEND TO ARRAY:C911($arrLangPtr->; "Hungarian=hun")
APPEND TO ARRAY:C911($arrLangPtr->; "Korean=kor")
APPEND TO ARRAY:C911($arrLangPtr->; "Italian=ita")
APPEND TO ARRAY:C911($arrLangPtr->; "Japanese=jpn")
APPEND TO ARRAY:C911($arrLangPtr->; "Norwegian=nor")
APPEND TO ARRAY:C911($arrLangPtr->; "Polish=pol")
APPEND TO ARRAY:C911($arrLangPtr->; "Portuguese=por")
APPEND TO ARRAY:C911($arrLangPtr->; "Russian=rus")
APPEND TO ARRAY:C911($arrLangPtr->; "Spanish=spa")
APPEND TO ARRAY:C911($arrLangPtr->; "Swedish=swe")
APPEND TO ARRAY:C911($arrLangPtr->; "Turkish=tur")