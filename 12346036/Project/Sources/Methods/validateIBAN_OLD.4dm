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
// ------------------------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($IBAN)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8)
C_POINTER:C301($errorCode; $bankName; $countryCode; $city; $address; $swift; $validCheckSum)

$IBAN:=$1
$errorCode:=$2
$bankName:=$3
$countryCode:=$4
$city:=$5
$address:=$6
$swift:=$7
$validCheckSum:=$8

// Local Variables
C_TEXT:C284(url; xmlData; $APIKEY; $xmlRef; $element)

C_LONGINT:C283($httpResponse)
ARRAY TEXT:C222(attrNames; 0)
ARRAY TEXT:C222(attrValues; 0)

$APIKEY:="ceef5524cecb23cb780ab0a6bd937195"  // Constant
url:="https://www.iban.com/clients/api/iban-api.php?api_key="+$APIKEY+"&iban="+$IBAN

// Request to external web service
$httpResponse:=getXML

If ($httpResponse=0)  // Response ok?
	
	$xmlRef:=DOM Parse XML variable:C720(xmlData)
	ON ERR CALL:C155("")
	
	// Ask for results
	$element:=DOM Find XML element:C864($xmlRef; "result/bank_name")
	
	Case of 
			
		: (OK=1)
			
			// Parse results
			$errorCode->:=""
			
			$element:=DOM Find XML element:C864($xmlRef; "result/bank_name")
			DOM GET XML ELEMENT VALUE:C731($element; $bankName->)
			
			$element:=DOM Find XML element:C864($xmlRef; "result/country_code")
			DOM GET XML ELEMENT VALUE:C731($element; $countryCode->)
			
			$element:=DOM Find XML element:C864($xmlRef; "result/city")
			DOM GET XML ELEMENT VALUE:C731($element; $city->)
			
			$element:=DOM Find XML element:C864($xmlRef; "result/address")
			DOM GET XML ELEMENT VALUE:C731($element; $address->)
			
			$element:=DOM Find XML element:C864($xmlRef; "result/swift")
			DOM GET XML ELEMENT VALUE:C731($element; $swift->)
			
			$element:=DOM Find XML element:C864($xmlRef; "result/valid")
			DOM GET XML ELEMENT VALUE:C731($element; $validCheckSum->)
			
		: (OK=0)
			// Parse error message
			$element:=DOM Find XML element:C864($xmlRef; "error")
			DOM GET XML ELEMENT VALUE:C731($element; $errorCode->)
			
	End case 
	
	// Memory clean
	DOM CLOSE XML:C722($xmlRef)
	
Else 
	$errorCode->:="IBAN Web Service not available, try again. Url: "+url+". Error code: "+String:C10(gError)
End if 

