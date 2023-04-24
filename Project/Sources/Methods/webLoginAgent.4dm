//%attributes = {"shared":true,"publishedWeb":true}


//TRACE

C_TEXT:C284(webPassword; webUsername; webContext)
C_LONGINT:C283($webMessageType)
C_TEXT:C284($webErrorMessage)


C_BOOLEAN:C305($bValid)

C_OBJECT:C1216($entity)
C_TEXT:C284($tContext)
C_LONGINT:C283($iElem)


$bValid:=False:C215
$tContext:="agents"
READ ONLY:C145([Agents:22])
READ WRITE:C146([WebUsers:14])



//-----------  OLD -----------
//this using [agents] as opposed to [webusers] --- <>TODO ... need to revisit

// Login with user name or email entered in webUsername Field
//QUERY([Agents];[Agents]AgentID=webUsername;*)
//QUERY([Agents]; & ;[Agents]Password=webPassword;*)
//QUERY([Agents]; & ;[Agents]isAllowedAccess=True)

webUsername:=strRemoveSpaces(WAPI_getParameter("webusername"))
webPassword:=strRemoveSpaces(WAPI_getParameter("webpassword"))

$entity:=ds:C1482.Agents.query("AgentID == :1  AND Password IS :2 AND isAllowedAccess == :3"; webUsername; webPassword; True:C214)
If ($entity.length=0)
	$entity:=ds:C1482.Agents.query("Email IS :1  AND Password IS :2 AND isEmailConfirmed == :3"; webUsername; webPassword; True:C214)  //are they logging in with email?
End if 

Case of 
	: ($entity.length=1)
		USE ENTITY SELECTION:C1513($entity)
		LOAD RECORD:C52([Agents:22])
		
		$bValid:=True:C214
		
		QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=[Agents:22]AgentID:1)
		If (Records in selection:C76([WebUsers:14])=0)
			CREATE RECORD:C68([WebUsers:14])
			[WebUsers:14]webUsername:1:=[Agents:22]AgentID:1
			[WebUsers:14]Email:3:=[Agents:22]email:8
			[WebUsers:14]relatedTable:8:=Table:C252(->[Agents:22])
			[WebUsers:14]recordID:9:=[Agents:22]AgentID:1
			[WebUsers:14]confirmationToken:6:=""
			//[WebUsers]unused:=True
			[WebUsers:14]isEmailConfirmed:12:=True:C214
			[WebUsers:14]isLocked:10:=False:C215
			[WebUsers:14]isTokenConfirmed:17:=True:C214
		End if 
		
		[WebUsers:14]incorrectPasswordCount:4:=0
		[WebUsers:14]lastLoginDate:15:=Current date:C33(*)
		[WebUsers:14]lastLoginTime:16:=Current time:C178(*)
		SAVE RECORD:C53([WebUsers:14])
		
		webLoginCreateLog  // this is throwing a syntax error on the compiler #TB
		
	: ($entity.length=0)
		
	Else   //multiple
		
End case 



C_TEXT:C284($sessionId)
If ($bValid)  // Create or update the session
	$sessionId:=WEB Get current session ID:C1162
	
	WAPI_createSession($sessionId)
	WAPI_authorizeSession
	WAPI_setSession("username"; webUsername)
	WAPI_setSession("context"; $tContext)
	WAPI_setSession("email"; [Agents:22]email:8)
	WAPI_setSession("login"; "true")
	
	WAPI_setAlertMessage("Login correct, Welcome"; 1)
	webSendWelcomePage
	
Else 
	//QUERY([Agents];[Agents]AgentID=webUsername)
	
	$entity:=ds:C1482.Agents.query("AgentID == :1"; webUsername)
	If ($entity.length=0)
		$entity:=ds:C1482.Agents.query("Email IS :1 "; webUsername)  //are they logging in with email?
	End if 
	
	If ($entity.length=1)  //track incorrect password attempts
		USE ENTITY SELECTION:C1513($entity)
		LOAD RECORD:C52([Agents:22])
		
		QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=[Agents:22]AgentID:1)
		
		If (Records in selection:C76([WebUsers:14])=1)
			[WebUsers:14]incorrectPasswordCount:4:=[WebUsers:14]incorrectPasswordCount:4+1
			
			Case of 
				: ([WebUsers:14]incorrectPasswordCount:4=2)
					$webErrorMessage:="After the next unsuccessful login attempt your account will be put on hold."
					$webMessageType:=3
					
				: ([WebUsers:14]incorrectPasswordCount:4>=3)
					[WebUsers:14]isLocked:10:=True:C214
					[WebUsers:14]confirmationToken:6:=generateRandomString(12)
					webSendAccountOnHoldEmail([WebUsers:14]Email:3)
					
					$webErrorMessage:="Due to unsuccessful login attempts your account has been put on hold. Contact support."
					$webMessageType:=4
					
				Else 
					If ([WebUsers:14]isLocked:10)
						$webErrorMessage:="<b>Your account is on hold at this moment</b>. Contact support."
						$webMessageType:=4
					Else 
						$webErrorMessage:="Login incorrect, try again"
						$webMessageType:=4
						webSendUnusualActivityEmail([WebUsers:14]Email:3)
					End if 
					
			End case 
			
			SAVE RECORD:C53([WebUsers:14])
		End if 
		
	Else 
		$webErrorMessage:="Username Not Found, try again"
		$webMessageType:=4
	End if 
	
	//set error message
	WAPI_setAlertMessage($webErrorMessage; $webMessageType)
	webSendLoginPage
	
End if 

UNLOAD RECORD:C212([WebUsers:14])
READ ONLY:C145([WebUsers:14])
LOAD RECORD:C52([WebUsers:14])