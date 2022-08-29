//%attributes = {}

// Method: TranslateKeyword ($sourceText; {$targetLang}) -> String

C_TEXT:C284($0; $1; $sourceText)
C_TEXT:C284($targetLang; $translateDir; $targetText)
$sourceText:=$1

If (Count parameters:C259=2)
	C_TEXT:C284($2)
	$targetLang:=$2
Else 
	$targetLang:=GetCurrentLocalization
End if 

$translateDir:=Substring:C12($targetLang; 1; 2)  // Translate direction for Google Translator
$targetText:=XLIFF_TranslateUsingGoogleApi($sourceText; $translateDir)
$targetText:=Replace string:C233($targetText; "&quot;"; "'")  // &#39;
$targetText:=Replace string:C233($targetText; "&#39;"; "'")  // 
$0:=$targetText