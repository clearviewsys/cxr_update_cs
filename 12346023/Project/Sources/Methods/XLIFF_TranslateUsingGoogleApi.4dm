//%attributes = {}

// ------------------------------------------------------------------------------
// Method: XLIFF_TranslateUsingGoogleApi: 
// Consumes a HTTP REST Web Service and parse the response in 4D Variables             
// Parameters: 
//   $1: keyword  (Input - String)  // Keyword to translate
//   $2: langDirection (Input - String) // Language DIrection (eg. en-es (English to Spanish), en-de (English to German)
// Returns:
//   $0: Keyword in the new language
// ------------------------------------------------------------------------------
// CVS Dev. Team, 03/02/2016  (mm/dd/yyyy)
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $2; $0)
// Local Variables
C_TEXT:C284(url)
C_OBJECT:C1216(textData)

C_BOOLEAN:C305($isOk)
$isOk:=True:C214

C_TEXT:C284($result)
C_OBJECT:C1216($jsonData; $data; $parsed; $data)
ARRAY OBJECT:C1221($translations; 0)

C_LONGINT:C283($httpResponse)
ARRAY TEXT:C222(attrNames; 0)
ARRAY TEXT:C222(attrValues; 0)
C_TEXT:C284($KEY)

// Google API is used to translate
// Documentation URL: 
// https://cloud.google.com/translate/v2/quickstart#translate-text

$KEY:="AIzaSyAO-TwD3dcu981WyHc_s3K7KRL-gpRNp-4"
//$isOk:=PHP Execute("";"urlencode";$encodedSourceText;$1)

url:="https://www.googleapis.com/language/translate/v2?"
url:=url+"key="+$KEY

//If ($isOk)
//url:=url+"&q="+$encodedSourceText
//Else 
//url:=url+"&q="+$1
//End if 

url:=url+"&q="+$1
url:=url+"&source=en"
url:=url+"&target="+Substring:C12($2; 1; 2)

// Request to external web service
$httpResponse:=XLIFF_GetGoogleTrAPI
$0:=""



If ($httpResponse=200)  // Response from Google API is Ok?
	
	CLEAR VARIABLE:C89($translations)
	CLEAR VARIABLE:C89($data)
	
	
	$parsed:=OB Copy:C1225(textData)
	$data:=OB Copy:C1225($parsed)  //;"data.translations")
	
	$parsed:=OB Copy:C1225($data)
	
	//OB GET ARRAY($data;"";$translations)
	OB GET ARRAY:C1229($data; "translations"; $translations)
	
	
	
	If (Size of array:C274($translations)>0)
		$result:=OB Get:C1224($translations{1}; "translatedText"; Is text:K8:3)
		$0:=$result
	End if 
	
Else 
	$0:="Translation Error #: "+String:C10($httpResponse)
End if 

