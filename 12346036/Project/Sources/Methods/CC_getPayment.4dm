//%attributes = {"shared":true}
//**************************************************************
//Method for Finding a payment on the Currency Cloud Platform
//
//Required Parameters:
//@Error (Pointer): Pointer to text variable
//@payment ID (String): UUID of payment
//@Auth (String): Either authKey or email and apiKey
//
//Outputs:
//On Success: Object containing payment information
//On Failure: Object containing error code, error message -> @Error
//**************************************************************

C_OBJECT:C1216($0)
C_TEXT:C284($URL; $payId; $authKey; $body; $response; $2; $3; $4)
C_LONGINT:C283($i; $status)
C_POINTER:C301($pError; $pHeaderNames; $pHeaderValues; $1)

//Two accepted possibilities:
//User is pre-authenticated and passes in just the auth key
//User is not authenticaed and passes in email and api key
ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
$pError:=$1
Case of 
	: (Count parameters:C259=3)
		
		$payId:=$2
		$authKey:=$3
		
	: (Count parameters:C259=4)
		C_TEXT:C284($email; $apiKey)
		
		$payId:=$2
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
	
	$body:="id="+$payId
	
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
		$URL+"/payments/"+$payId; \
		$body; $response; $headerNames; $headerValues)
	
	CC_createLogRecord("GET payments/"; $body; String:C10($status); $response)
	
	If ($status=200)
		
		//Since no error on the request, we pass the error pointer to the Logout function
		If (Count parameters:C259=4)
			CC_logout($authKey; $pError)
		End if 
		//Converts the response (JSON String) into a JSON object
		$0:=JSON Parse:C1218($response)
	Else 
		//If there were errors from the request, we prefer to return those 
		//over any from Logout, So we don't pass the error pointer
		If (Count parameters:C259=4)
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
	//Login unsuccessful
	$0:=New object:C1471("errorCode"; $authKey)
End if 
