//%attributes = {"publishedWeb":true}

C_TEXT:C284($1)

C_TEXT:C284($xurl; $vTcookie; $webErrorMessage)
C_BOOLEAN:C305($enforceLogin)
C_LONGINT:C283($webMessageType)

$enforceLogin:=Choose:C955($1="@false"; False:C215; True:C214)

Case of 
	: ($enforceLogin) & (WAPI_getSession("login")="true")
		//all good they are logged in
		
	: ($enforceLogin=False:C215) & (webIsSessionAlive)  //***need to test for correct webContext as well - might need to force all activity thru on web connection
		//all good don't need to be logged in
		
	Else   //not valid session
		
		// redirect to the login page
		$webErrorMessage:="Please login to continue."
		$webMessageType:=2
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		
		WEB SEND HTTP REDIRECT:C659("login.shtml")
End case 

