//%attributes = {"shared":true}
//**************************************************************
//Method for Creating a Payment on the Currency Cloud Platform
//Checks the balance of the account before sending and returns an 
//error if the account does not have a high enough balance
//
//Required Parameters:
//@Auth (String): Either authKey or email and apiKey
//@Payment (Object): Contains all fields for payment
//@Error (Pointer): Pointer to text variable
//
//Outputs:
//On Success: Payment ID
//On Failure: Status code of error, error message -> @Error
//**************************************************************

C_TEXT:C284($URL; $authKey; $0; $3; $4)
C_OBJECT:C1216($2; $payment)
C_POINTER:C301($1; $pError; $pHeaderNames; $pHeaderValues)
C_LONGINT:C283($status; $i)
C_BOOLEAN:C305($correct)
$0:=""

//Two accepted possibilities:
//User is pre-authenticated and passes in just the auth key
//User is not authenticaed and passes in email and api key
ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
$pError:=$1
$payment:=$2
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
	$correct:=CC_checkRequiredPay($payment; $pError)
	
	If ($correct)
		C_OBJECT:C1216($account)
		$account:=CC_getBalance($pError; $payment.currency; $authKey)
		
		If ($account.errorCode=Null:C1517)
			//Success
			//Account object has following parameters:
			//account_id, amount, created_at, currency, id, updated_at
			If (Num:C11($account.amount)<Num:C11($payment.amount))
				$correct:=False:C215
				$pError->:="Account containing provided currency does not contain enough funds for payment"\
					
			End if 
			
		Else 
			//Error getting balance
			$correct:=False:C215
			
		End if 
	End if 
	
	If ($correct)
		
		C_TEXT:C284($body; $response; $ret)
		ARRAY TEXT:C222($paramNames; 0)
		OB GET PROPERTY NAMES:C1232($payment; $paramNames)
		
		//Populate the request body with the names and values of each parameter
		For ($i; 1; Size of array:C274($paramNames))
			If ($i>1)
				$body:=$body+"&"
			End if 
			$body:=$body+$paramNames{$i}+"="+$payment[$paramNames{$i}]
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
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; \
			$URL+"/payments/create"; \
			$body; $response; $headerNames; $headerValues)
		
		CC_createLogRecord("POST payments/create"; $body; String:C10($status); $response)
		
		If ($status=200)
			C_OBJECT:C1216($oResponse)
			
			//Converts the response (JSON String) into a JSON object
			$oResponse:=JSON Parse:C1218($response)
			
			//Returns the payment id
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
		//OR
		//Account does not have enough funds for payment
		//Error pointer set above 
		
		CC_createLogRecord("POST payments/create"; ""; String:C10(400); $pError->)
		
		If (Count parameters:C259=4)
			$ret:=CC_logout($authKey)
		End if 
		
		$0:="400"
		
	End if 
Else 
	//Error Logging in
	//Error pointer set within the Login function
	$0:=$authKey
End if 