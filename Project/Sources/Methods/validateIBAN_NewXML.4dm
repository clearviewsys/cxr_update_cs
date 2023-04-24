//%attributes = {}

// ------------------------------------------------------------------------------
// Method: validateIBAN: 
// Consumes a HTTP REST Web Service and parse the response in 4D Variables             
// Parameters: 
//   $1: IBAN  (Input - String) 
//   $2: errorCode (Pointer String)
//   $3: bankName (Pointer String)
//   $4: countryCode (Pointer String)
//   $5: city (Pointer String)
//   $6: address (Pointer String)
//   $7: swift (Pointer String)
//   $8: validCheckSum (Pointer String)
// 
// ------------------------------------------------------------------------------
// Jaime Alvarez, 08/03/2015
// Viktor Dojnov, 15/01/2021
// ------------------------------------------------------------------------------

// Unit test is written @Viktor

C_TEXT:C284($1)
C_TEXT:C284($IBAN)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8)
C_POINTER:C301($errorCode; $bankName; $countryCode; $city; $address; $swift; $validCheckSum)

$IBAN:=Replace string:C233($1; " "; "")  // Get rid of Spaces in IBAN to prevent errors in Http request
$errorCode:=$2
$bankName:=$3
$countryCode:=$4
$city:=$5
$address:=$6
$swift:=$7
$validCheckSum:=$8

// Local Variables
C_TEXT:C284(url; xmlData; $APIKEY; $xmlRef; $element; $bankData)

C_LONGINT:C283($httpResponse)
ARRAY TEXT:C222(attrNames; 0)
ARRAY TEXT:C222(attrValues; 0)

$APIKEY:="ceef5524cecb23cb780ab0a6bd937195"  // Constant
url:="https://api.iban.com/clients/api/v4/iban/?api_key="+$APIKEY+"&format=xml&iban="+$IBAN

// Request to external web service
$httpResponse:=getXML

If ($httpResponse=0)  // Response ok?
	
	$xmlRef:=DOM Parse XML variable:C720(xmlData)
	ON ERR CALL:C155("")
	
	// Ask for results
	$bankData:="result/bank_data"
	$element:=DOM Find XML element:C864($xmlRef; "result")
	
	Case of 
			
		: (OK=1)
			
			// Parse results
			$errorCode->:=""
			
			$element:=DOM Find XML element:C864($xmlRef; $bankData+"/bank")
			DOM GET XML ELEMENT VALUE:C731($element; $bankName->)
			
			$element:=DOM Find XML element:C864($xmlRef; $bankData+"/country_iso")
			DOM GET XML ELEMENT VALUE:C731($element; $countryCode->)
			
			$element:=DOM Find XML element:C864($xmlRef; $bankData+"/city")
			DOM GET XML ELEMENT VALUE:C731($element; $city->)
			
			$element:=DOM Find XML element:C864($xmlRef; $bankData+"/address")
			DOM GET XML ELEMENT VALUE:C731($element; $address->)
			
			$element:=DOM Find XML element:C864($xmlRef; $bankData+"/bic")
			DOM GET XML ELEMENT VALUE:C731($element; $swift->)
			
			$element:=DOM Find XML element:C864($xmlRef; "result/validations"+"/account/message")
			DOM GET XML ELEMENT VALUE:C731($element; $validCheckSum->)
			
			//-------------------------------------------------------------------
			
			// Parse error message
			C_TEXT:C284($resultValidations; $code; $currentError)
			C_LONGINT:C283($errNum; $charsCode)
			$resultValidations:="result/validations"
			$errNum:=1
			
			// CHARS
			$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/chars/code")
			DOM GET XML ELEMENT VALUE:C731($element; $charsCode)
			If (Num:C11($charsCode)>100)
				$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/chars/message")
				DOM GET XML ELEMENT VALUE:C731($element; $currentError)
				$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$currentError+"."
				$errNum:=$errNum+1
			End if 
			
			// IBAN
			$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/iban/code")
			DOM GET XML ELEMENT VALUE:C731($element; $charsCode)
			If (Num:C11($charsCode)>100)
				$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/iban/message")
				DOM GET XML ELEMENT VALUE:C731($element; $currentError)
				$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$currentError+"."
				$errNum:=$errNum+1
			End if 
			
			// ACCOUNT
			$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/account/code")
			DOM GET XML ELEMENT VALUE:C731($element; $charsCode)
			If (Num:C11($charsCode)>100)
				$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/account/message")
				DOM GET XML ELEMENT VALUE:C731($element; $currentError)
				$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$currentError+"."
				$errNum:=$errNum+1
			End if 
			
			// STRUCTURE
			$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/structure/code")
			DOM GET XML ELEMENT VALUE:C731($element; $charsCode)
			If (Num:C11($charsCode)>100)
				$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/structure/message")
				DOM GET XML ELEMENT VALUE:C731($element; $currentError)
				$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$currentError+"."
				$errNum:=$errNum+1
			End if 
			
			// LENGTH
			$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/length/code")
			DOM GET XML ELEMENT VALUE:C731($element; $charsCode)
			If (Num:C11($charsCode)>100)
				$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/length/message")
				DOM GET XML ELEMENT VALUE:C731($element; $currentError)
				$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$currentError+"."
				$errNum:=$errNum+1
			End if 
			
			// COUNTRY SUPPORT
			$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/country_support/code")
			DOM GET XML ELEMENT VALUE:C731($element; $charsCode)
			If (Num:C11($charsCode)>100)
				$element:=DOM Find XML element:C864($xmlRef; $resultValidations+"/country_support/message")
				DOM GET XML ELEMENT VALUE:C731($element; $currentError)
				$errorCode->:=$errorCode->+" "+String:C10($errNum)+". "+$currentError+"."
				$errNum:=$errNum+1
			End if 
			
	End case 
	
	// Memory clean
	DOM CLOSE XML:C722($xmlRef)
	
Else 
	$errorCode->:="IBAN Web Service not available, try again. Url: "+url+". Error code: "+String:C10(gError)
End if 

