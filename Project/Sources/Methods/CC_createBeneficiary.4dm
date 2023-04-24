//%attributes = {"shared":true}
//**************************************************************
//Method for Creating a Beneficiary on the Currency Cloud Platform
//
//Required Parameters:
//@Error (Pointer): Pointer to text variable
//@Beneficiary (Object): Contains all fields for beneficiary
//@Auth (String): Either authKey or email and apiKey
//
//Outputs:
//On Success: Beneficiary ID
//On Failure: Status code of error, error message -> @Error
//**************************************************************

C_TEXT:C284($URL; $authKey; $0; $3; $4)
C_OBJECT:C1216($beneficiary; $2)
C_POINTER:C301($pError; $1; $pHeaderNames; $pHeaderValues)
C_LONGINT:C283($status; $i)
C_BOOLEAN:C305($correct)
$0:=""

//Two accepted possibilities:
//User is pre-authenticated and passes in just the auth key
//User is not authenticaed and passes in email and api key

ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
$pError:=$1
$beneficiary:=$2

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
	
	//Check for parameters required independant of currency type
	//Only contiue if the check was successful
	$correct:=CC_checkRequiredBen($beneficiary; $pError)
	If ($correct)
		
		C_TEXT:C284($body; $response; $ret)
		ARRAY TEXT:C222($paramNames; 0)
		OB GET PROPERTY NAMES:C1232($beneficiary; $paramNames)
		
		//Populate the request body with the names and values of each parameter
		For ($i; 1; Size of array:C274($paramNames))
			If ($i>1)
				$body:=$body+"&"
			End if 
			$body:=$body+$paramNames{$i}+"="+$beneficiary[$paramNames{$i}]
		End for 
		
		//Set header names and values as text arrays
		ARRAY TEXT:C222($headerNames; 0)
		ARRAY TEXT:C222($headerValues; 0)
		$pHeaderNames:=->$headerNames
		$pHeaderValues:=->$headerValues
		CC_setHeadersAuth($pHeaderNames; $pHeaderValues; $body; $authKey)
		
		//Send the request
		//Response is put into the $response var
		$URL:=CC_getUrlKeyValue
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; $URL+"/beneficiaries/create"; $body; $response; $headerNames; $headerValues)
		
		CC_createLogRecord("POST beneficiaries/create"; $body; String:C10($status); $response)
		
		If ($status=200)
			C_OBJECT:C1216($oResponse)
			
			//Converts the response (JSON String) into a JSON object
			$oResponse:=JSON Parse:C1218($response)
			
			//Returns the beneficiary id
			$0:=$oResponse.id
			If (Count parameters:C259=4)
				$ret:=CC_logout($authKey; $pError)
			End if 
			
		Else 
			$0:=String:C10($status)
			
			//If there are multiple errors, the $oResponse will have all these errors as params
			//The following code concatenates all the errors into a single string which can
			//be returned
			C_OBJECT:C1216($oError)
			C_TEXT:C284($errorMessage)
			ARRAY TEXT:C222($errorParams; 0)
			
			//Parse the response into an object and get the errors
			$oError:=JSON Parse:C1218($response)
			OB GET PROPERTY NAMES:C1232($oError.error_messages; $errorParams)
			
			//For each error, add on the message on a new line of the $errorMessage var
			For ($i; 1; Size of array:C274($errorParams))
				$errorMessage:=$errorMessage+Char:C90(13)+$oError.error_messages[$errorParams{$i}][0].message
			End for 
			$pError->:=$errorMessage
			If (Count parameters:C259=4)
				$ret:=CC_logout($authKey)
			End if 
		End if 
		
	Else 
		//Missing required params
		//Error pointer set within the Check_Required_Ben function 
		CC_createLogRecord("POST beneficiaries/create"; ""; "400"; $pError->)
		
		If (Count parameters:C259=4)
			$ret:=CC_logout($authKey)
		End if 
		
		$0:="400"
	End if 
Else 
	//Error Loggin in
	//Error pointer srt within the Login function
	$0:=$authKey
End if 