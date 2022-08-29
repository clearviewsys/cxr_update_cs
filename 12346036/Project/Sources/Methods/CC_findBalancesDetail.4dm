//%attributes = {"shared":true}
//**************************************************************
//Method for Finding Balances of accounts on the Currency Cloud Platform
//
//Required Parameters:
//@Error (Pointer): Pointer to text variable
//@Array (Pointer): Pointer to text arrays
//@Auth (String): Either authKey or email and apiKey


//
//Outputs:
//On Success: Satus code(200), @Array contains payment IDs
//On Failure: Status code of error, error message -> @Error
//**************************************************************

C_TEXT:C284($URL; $authKey; $body; $response; $0; $3; $4)
C_LONGINT:C283($status; $i)
C_POINTER:C301($pError; $pArray; $pHeaderNames; $pHeaderValues; $1; $2)
C_OBJECT:C1216($oResponse)

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
		$URL+"/balances/find"; \
		$body; $response; $headerNames; $headerValues)
	
	CC_createLogRecord("GET balances/find"; "auth_token="+$authKey; String:C10($status); $response)
	
	$0:=String:C10($status)
	If ($status=200)
		
		//Converts the response (JSON String) into a JSON object
		$oResponse:=JSON Parse:C1218($response; 38)
		
		//Copies the account currencies to an array
		ARRAY TEXT:C222($IDs; 0)
		For ($i; 0; $oResponse.balances.length-1)
			APPEND TO ARRAY:C911($IDs; $oResponse.balances[$i].currency+": "+$oResponse.balances[$i].amount)
		End for 
		
		//Returns the arrays of IDs in the array passed in
		COPY ARRAY:C226($IDs; $pArray->)
		
		//Since no error on the request, we pass the error pointer to the Logout function
		If (Count parameters:C259=4)
			CC_logout($authKey; $pError)
		End if 
	Else 
		//If there were errors from the request, we prefer to return thos over any from Logoout
		//So we don't pass the error pointer
		If (Count parameters:C259=4)
			CC_logout($authKey)
		End if 
		$pError->:=$response
	End if 
	
	
Else 
	//Login unsuccessful
	$0:="Error: "+$authKey+" on Login. Please check your login credentials"
End if 
