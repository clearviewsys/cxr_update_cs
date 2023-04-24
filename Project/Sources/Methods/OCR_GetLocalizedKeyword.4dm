//%attributes = {}
// OCR_GetLocalizedKeyword ($keyword)
// Gets the $keyword Localized from table [Translations]

C_TEXT:C284($0; $1; $keyword; $language; $targetText)

Case of 
	: (Count parameters:C259=1)
		$keyword:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$language:=GetCurrentLocalization
//$language:="it-CH"  // it-CH es-ES  de-CH

If ($language#"en-US")
	
	Begin SQL
		SELECT t.DB_Translation 
		FROM DB_Translations t, DB_Keywords k 
		WHERE t.KeywordID = k.ID AND k.keyword = :$keyword AND t.languageCode = :$language
		INTO :$targetText
	End SQL
	
Else 
	
	Begin SQL
		SELECT k.sourceText
		FROM DB_Keywords k 
		WHERE k.keyword = :$keyword
		INTO :$targetText
	End SQL
	
End if 


$0:=$targetText
