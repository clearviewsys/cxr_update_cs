//%attributes = {"shared":true}
//**************************************************************
//Method for getting conversion rates on the Currency Cloud Platform
//
//Required Parameters (Both):
//@Error (Pointer): Pointer to text variable
//@Auth (String): Either authKey or email and apiKey
//
//Required Parameters (Basic):
//@Currency Pair (String): Concatenated string of currencies traded
//
//Required Parameters(Detailed): 
//@Buy Currency(String): Currency purchased.Three-digit code, eg."USD"
//@Sell Currency(String):Currency sold.Three-digit code, eg."CAD"
//@Fixed Side(String): "buy"or"sell"
//@Amount(String): Amount to be converted
//
//Outputs:
//On Success (basic): Object containing low and high conversion rates
//On Success (detailed): Object containing conversion details
//On Failure: Object containing error code, error message -> @Error
//**************************************************************

C_TEXT:C284($URL; $authKey; $2; $3; $4; $5; $6; $7)
C_POINTER:C301($pError; $1)
C_BOOLEAN:C305($isBasic)
C_BOOLEAN:C305($curValid)
C_LONGINT:C283($i)

//Four accepted posibilities:
//User is pre-authenticated and is performing a basic rate get
//User is not authenticaed and is performing a basic rate get
//User is pre-authenticated and is performing a detailed rate get
//User is not authenticaed and is performing a detailed rate get

ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
$pError:=$1

Case of 
	: (Count parameters:C259=3)
		//Basic conversion pre-authenticated
		C_TEXT:C284($currencyPair)
		
		$authKey:=$2
		$currencyPair:=$3
		
		$isBasic:=True:C214
		$curValid:=CC_isValidCurrency($pError; $currencyPair; $authKey)
		
	: (Count parameters:C259=4)
		//Basic conversion not authenticated
		C_TEXT:C284($email; $apiKey; $currencyPair)
		
		$email:=$2
		$apiKey:=$3
		$currencyPair:=$4
		
		$authKey:=CC_login($email; $apiKey; $pError)
		
		$isBasic:=True:C214
		$curValid:=CC_isValidCurrency($pError; $currencyPair; $authKey)
		
	: (Count parameters:C259=6)
		//Detailed conversion pre-authenticated
		C_TEXT:C284($buyCurrency; $sellCurrency; $fixedSide; $amount)
		
		$authKey:=$2
		$buyCurrency:=$3
		$sellCurrency:=$4
		$fixedSide:=$5
		$amount:=String:C10($6)
		
		$isBasic:=False:C215
		$curValid:=CC_isValidCurrency($pError; $buyCurrency; $sellCurrency; $authKey)
		
	: (Count parameters:C259=7)
		//Detailed conversion pre-authenticated
		
		C_TEXT:C284($buyCurrency; $sellCurrency; $fixedSide; $amount; $email; $apiKey)
		
		$email:=$2
		$apiKey:=$3
		$buyCurrency:=$4
		$sellCurrency:=$5
		$fixedSide:=$6
		$amount:=String:C10($7)
		
		$authKey:=CC_login($email; $apiKey; $pError)
		
		$isBasic:=False:C215
		$curValid:=CC_isValidCurrency($pError; $buyCurrency; $sellCurrency; $authKey)
		
	Else 
		$authKey:="450"
End case 

//Successful login will return the auth key,
//Unsuccessful returns the error code
//So,we can check for login success based on the length of the auth key
If (Length:C16($authKey)>3)
	
	//Currency Cloud doesn't provide detailed errors if a currency code is invalid.
	//Is_Valid_Currency checks these currency codes against all the valid codes
	If ($curValid)
		C_TEXT:C284($query; $body; $response)
		C_LONGINT:C283($status)
		C_POINTER:C301($pHeaderNames; $pHeaderValues)
		
		//Final path level and query string vary based on type of request
		If ($isBasic)
			
			$query:="find?currency_pair="+$currencyPair
			
		Else 
			$query:="detailed?buy_currency="+$buyCurrency
			$query:=$query+"&sell_currency="+$sellCurrency
			$query:=$query+"&fixed_side="+$fixedSide
			$query:=$query+"&amount="+$amount
			
		End if 
		
		//Set header names and values as text arrays
		ARRAY TEXT:C222($headerNames; 0)
		ARRAY TEXT:C222($headerValues; 0)
		$pHeaderNames:=->$headerNames
		$pHeaderValues:=->$headerValues
		
		//Sets the header values, including the length, type, and auth key
		CC_setHeadersAuth($pHeaderNames; $pHeaderValues; $body; $authKey)
		
		//Send the request
		//Response is put into the $response var
		$URL:=CC_getUrlKeyValue
		$status:=HTTP Request:C1158(HTTP GET method:K71:1; \
			$URL+"/rates/"+$query; \
			$body; $response; $headerNames; $headerValues)
		
		CC_createLogRecord("GET rates/"+$query; ""; String:C10($status); $response)
		
		If ($status=200)
			
			//Since no error on the request, we pass the error pointer to the Logout function
			If ((Count parameters:C259=4) | (Count parameters:C259=7))
				CC_logout($authKey; $pError)
			End if 
			//Converts the response (JSON String) into a JSON object
			C_OBJECT:C1216($oResponse)
			$oResponse:=JSON Parse:C1218($response)
			If ($isBasic)
				//Custom object, with field for low rate and high rate
				$0:=New object:C1471("low"; $oResponse.rates[$currencyPair][0]; "high"; $oResponse.rates[$currencyPair][1])
			Else 
				//Returns parsed object
				$0:=$oResponse
			End if 
		Else 
			//If there were errors from the request, we prefer to return those 
			//over any from Logout, So we don't pass the error pointer
			If ((Count parameters:C259=4) | (Count parameters:C259=7))
				CC_logout($authKey)
			End if 
			
			C_OBJECT:C1216($oError)
			C_TEXT:C284($errorMessage)
			ARRAY TEXT:C222($errorParams; 0)
			
			//Converts the response (JSON String) into a JSON object
			$oError:=JSON Parse:C1218($response)
			//Copies all the names of the error messages to the $errorParams array
			OB GET PROPERTY NAMES:C1232($oError.error_messages; $errorParams)
			
			//Create a custom error message based on the number of errors
			//This is done for readability of the error message
			For ($i; 1; Size of array:C274($errorParams))
				$errorMessage:=$errorMessage+Char:C90(13)+$oError.error_messages[$errorParams{$i}][0].message
			End for 
			
			$pError->:=$errorMessage
			$0:=New object:C1471("errorCode"; $status)
		End if 
		
		
	Else 
		//At least one of the currency codes is not correct
		$0:=New object:C1471("errorCode"; "400")
		$pError->:="At least one currency code is invalid"
		
		If ((Count parameters:C259=4) | (Count parameters:C259=7))
			CC_logout($authKey)
		End if 
		
	End if 
Else 
	//Login unsuccessful
	$0:=New object:C1471("errorCode"; $authKey)
End if 
