//%attributes = {"publishedWeb":true}
C_TEXT:C284(webAlertHtml; $webErrorMessage; $body; $subject; $token; webEmailAddress; webToken)
C_TEXT:C284($webEmailAddress)
C_LONGINT:C283($webMessageType)

//webAlertHtml:=""
$webErrorMessage:=""
//webToken:=""

//checkInit 

//webResetPasswordValidation 


//If (isWebValidationConfirmed )  // if there is a warning or Error?
C_BOOLEAN:C305($isLoggedIn)
C_TEXT:C284($referPage)

$isLoggedIn:=Choose:C955(WAPI_getSession("login")="true"; True:C214; False:C215)

If ($isLoggedIn)
	$webEmailAddress:=WAPI_getSession("email")
	$referPage:="/"+WAPI_getSession("context")+"/home.shtml"  //WAPI_getPageReferrer 
Else 
	$webEmailAddress:=WAPI_getParameter("webEmailAddress")
	$referPage:=""
End if 


If ($webEmailAddress="")
	WAPI_setAlertMessage("Email address is NULL. Please try submitting the email address again."; 3)
	webSendForgotPasswordPage
Else 
	
	$token:=generateRandomString(8)
	
	READ WRITE:C146([WebUsers:14])
	
	QUERY:C277([WebUsers:14]; [WebUsers:14]Email:3=$webEmailAddress; *)
	QUERY:C277([WebUsers:14];  & ; [WebUsers:14]isEmailConfirmed:12=True:C214; *)
	QUERY:C277([WebUsers:14];  & ; [WebUsers:14]isLocked:10=False:C215)
	
	If (Records in selection:C76([WebUsers:14])=1)
		[WebUsers:14]isTokenConfirmed:17:=False:C215
		[WebUsers:14]confirmationToken:6:=$token
		SAVE RECORD:C53([WebUsers:14])
		webSendChangePasswordEmail($webEmailAddress; $token)
		
		$webErrorMessage:="We have sent a email to: <b> "+$webEmailAddress+"</b> with instructions to reset the password"
		$webMessageType:=1
		
		If (WAPI_getSession("context")="")
			WAPI_setSession("context"; Table name:C256([WebUsers:14]relatedTable:8))
		End if 
		
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		
		If ($isLoggedIn)
			WAPI_sendFile($referPage)
		Else 
			webSendChangePasswordPage
		End if 
		
		
	Else 
		$webErrorMessage:="The email address provided was NOT found: <b> "+$webEmailAddress+"</b> please correct and try again."
		$webMessageType:=2
		
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		webSendForgotPasswordPage
	End if 
	
	UNLOAD RECORD:C212([WebUsers:14])
	READ ONLY:C145([WebUsers:14])
	REDUCE SELECTION:C351([WebUsers:14]; 0)
	
End if 

//Else 

//If (checkErrorExist )
//<>CheckErrors:=Replace string(<>CheckErrors;"\r";"<br>")
//WAPI_setAlertMessage (<>CheckErrors;4)
//Else 

//If (checkWarningExist )
//<>CheckWarnings:=Replace string(<>CheckWarnings;"\r";"<br/>")
//WAPI_setAlertMessage (<>CheckWarnings;3)
//End if 

//End if 

//webSendForgotPasswordPage 

//End if 
