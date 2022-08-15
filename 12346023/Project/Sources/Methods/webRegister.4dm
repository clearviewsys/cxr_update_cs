//%attributes = {"publishedWeb":true}
C_TEXT:C284(webAlertHtml; $webErrorMessage; $body; $subject; $token; $tContext)
ARRAY TEXT:C222(arrTokens; 0)
C_BOOLEAN:C305(registrationOk)
C_LONGINT:C283($webMessageType)


webAlertHtml:=""
$webErrorMessage:=""
registrationOk:=False:C215

//trace
checkInit

webUserName:=WAPI_getParameter("userName")
webPassword:=WAPI_getParameter("userPassword")
webEmail:=WAPI_getParameter("userEmail")


//validateWebUsers2   //--- redundant ??? - yes and not Using ORDA query

If (isWebValidationConfirmed)  // if there is a warning or Error?
	
	$webErrorMessage:="Registration saved"
	$webMessageType:=1
	WAPI_setAlertMessage($webErrorMessage; $webMessageType)
	
	$token:=generateRandomString(8)
	
	CREATE RECORD:C68([WebUsers:14])
	[WebUsers:14]Email:3:=strTrim(webEmail)
	[WebUsers:14]Password:2:=strTrim(webPassword)
	[WebUsers:14]webUsername:1:=strTrim(webUserName)
	
	
	[WebUsers:14]phoneType:20:=WAPI_getParameter("userPhoneType")
	[WebUsers:14]phone:19:=WAPI_getParameter("userPhone")
	[WebUsers:14]creationDate:13:=Current date:C33(*)
	[WebUsers:14]creationTime:14:=Current time:C178(*)
	//[WebUsers]CountryCode:=webContryCode
	[WebUsers:14]isEmailConfirmed:12:=False:C215
	[WebUsers:14]confirmationToken:6:=$token
	Case of 
		: (webContext="customers")
			[WebUsers:14]relatedTable:8:=Table:C252(->[Customers:3])
		: (webContext="agents")
			[WebUsers:14]relatedTable:8:=Table:C252(->[Agents:22])
		Else 
			[WebUsers:14]relatedTable:8:=-1
	End case 
	[WebUsers:14]recordID:9:=""  //this gets set on confirmation/approval
	SAVE RECORD:C53([WebUsers:14])
	
	registrationOk:=True:C214
	
	webConfirmationToken:=[WebUsers:14]confirmationToken:6
	
	webSendConfirmationEmail(webEmail; [WebUsers:14]confirmationToken:6)
	webSendConfirmTokenPage
	
	UNLOAD RECORD:C212([WebUsers:14])  //11/7/18
	READ ONLY:C145([WebUsers:14])
	
Else 
	
	If (checkErrorExist)
		<>CheckErrors:=Replace string:C233(<>CheckErrors; "\r"; "<br>")
		WAPI_setAlertMessage(<>CheckErrors; 4)
	Else 
		
		If (checkWarningExist)
			<>CheckWarnings:=Replace string:C233(<>CheckWarnings; "\r"; "<br/>")
			WAPI_setAlertMessage(<>CheckWarnings; 3)
			
		End if 
		
	End if 
	
	$tContext:=WAPI_getSession("context")
	WAPI_sendFile("login/registration.shtml"; $tContext)
End if 
