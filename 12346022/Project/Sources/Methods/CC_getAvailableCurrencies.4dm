//%attributes = {"shared":true}
//**************************************************************
//Method to get a list of all the available currencies from the 
//Currency Cloud Platform
//
//Required Parameters:
//@Error (Pointer): Pointer to text variable
//@Array (Pointer): Pointer to text array
//@Auth (String): Either authKey or email and apiKey
//
//Outputs:
//On Success: Satus code(200), @Array contains currency codes
//On Failure: Status code of error, error message -> @Error
//**************************************************************

C_OBJECT:C1216($oResponse)
C_TEXT:C284($URL; $benId; $authKey; $body; $response; $0; $3; $4)
C_LONGINT:C283($status; $i)
C_POINTER:C301($pArray; $pError; $pHeaderNames; $pHeaderValues; $1; $2)

//Two accepted possibilities:
//User is pre-authenticated and passes in just the auth key
//User is not authenticaed and passes in email and api key
ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
$pError:=$1
ASSERT:C1129(Is nil pointer:C315($2)=False:C215)
$pArray:=$2


Case of 
	: (Count parameters:C259=3)
		
		$authKey:=$3
		
	: (Count parameters:C259=4)
		C_TEXT:C284($email; $apiKey)
		
		$email:=$3
		$apiKey:=$4
		
		$authKey:=CC_login($email; $apiKey; $pError)
	Else 
		$authKey:="450"
End case 

//Successful login will return the auth key,
//Unsuccessful returns the error code
//So,we can check for login success based on the length of the auth key
If (Length:C16($authKey)>3)
	//Login Successful
	
	$body:=""
	
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
		$URL+"/reference/currencies"; \
		$body; $response; $headerNames; $headerValues)
	
	CC_createLogRecord("GET reference/currencies"; ""; String:C10($status); $response)
	
	If ($status=200)
		
		//Converts the response (JSON String) into a JSON object
		$oResponse:=JSON Parse:C1218($response)
		
		//Creates an array of the currency codes
		ARRAY TEXT:C222($retArray; 0)
		For ($i; 0; $oResponse.currencies.length-1)
			APPEND TO ARRAY:C911($retArray; $oResponse.currencies[$i].code)
		End for 
		
		COPY ARRAY:C226($retArray; $pArray->)
		
		If (Count parameters:C259=4)
			CC_logout($authKey; $pError)
		End if 
		$0:=String:C10($status)
	Else 
		
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
		If (Count parameters:C259=4)
			CC_logout($authKey)
		End if 
		$pError->:=$errorMessage
		$0:=String:C10($status)
	End if 
	
	
Else 
	//Login unsuccessful
	$0:=$authKey
End if 
