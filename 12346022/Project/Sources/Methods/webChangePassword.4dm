//%attributes = {"publishedWeb":true}
C_TEXT:C284(webAlertHtml; $webErrorMessage; $body; $subject; $token; webEmailAddress)
C_TEXT:C284($webEmailAddress; $webToken)
C_LONGINT:C283($webMessageType)

webAlertHtml:=""
$webErrorMessage:=""

checkInit

webChangePasswordValidation


If (True:C214)  // (isWebValidationConfirmed)  // if there is a warning or Error?
	
	READ WRITE:C146([WebUsers:14])
	//$token:=generateRandomString (8)
	
	$webToken:=WAPI_getParameter("webToken")
	$webEmailAddress:=WAPI_getParameter("webEmailAddress")
	
	$webToken:=Replace string:C233($webToken; " "; "")
	$webEmailAddress:=Replace string:C233($webEmailAddress; " "; "")
	
	QUERY:C277([WebUsers:14]; [WebUsers:14]Email:3=$webEmailAddress; *)
	QUERY:C277([WebUsers:14];  & ; [WebUsers:14]isEmailConfirmed:12=True:C214; *)
	QUERY:C277([WebUsers:14];  & ; [WebUsers:14]isLocked:10=False:C215; *)
	QUERY:C277([WebUsers:14];  & ; [WebUsers:14]confirmationToken:6=$webToken)
	
	If (Records in selection:C76([WebUsers:14])=1)
		
		[WebUsers:14]isTokenConfirmed:17:=True:C214
		[WebUsers:14]confirmationToken:6:=""
		[WebUsers:14]Password:2:=WAPI_getParameter("userPassword")
		SAVE RECORD:C53([WebUsers:14])
		
		webSendPasswordChangedEmail($webEmailAddress)
		
		$webErrorMessage:="Password Changed Successfully"
		$webMessageType:=1
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		webSendLoginPage
	Else 
		QUERY:C277([WebUsers:14]; [WebUsers:14]Email:3=$webEmailAddress)
		
		If (Records in selection:C76([WebUsers:14])=1)
			webSendUnusualActivityEmail($webEmailAddress; "password change attempt")
			
			If (WAPI_getSession("context")="")
				WAPI_setSession("context"; Table name:C256([WebUsers:14]relatedTable:8))
			End if 
		End if 
		
		$webErrorMessage:="Information is incorrect. It was not possible to change the password. Try again"
		$webMessageType:=4
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		
		webSendChangePasswordPage
		
	End if 
	
	
Else 
	
	If (checkErrorExist)
		<>CheckErrors:=Replace string:C233(<>CheckErrors; "\r"; "<br>")
		WAPI_setAlertMessage(<>CheckErrors; 4)
	Else 
		
		If (checkWarningExist)
			<>CheckWarnings:=Replace string:C233(<>CheckWarnings; "\r"; "<br/>")
			WAPI_setAlertMessage(<>CheckWarnings; 4)
		End if 
		
	End if 
	
	webSendChangePasswordPage
	
End if 

UNLOAD RECORD:C212([WebUsers:14])
READ ONLY:C145([WebUsers:14])
REDUCE SELECTION:C351([WebUsers:14]; 0)

