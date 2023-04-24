//%attributes = {"shared":true,"publishedWeb":true}




C_TEXT:C284(webPassword; webUsername; webContext)
C_LONGINT:C283($webMessageType)
C_TEXT:C284($webErrorMessage; $tContext)
C_TEXT:C284($tCustomerID; $tWebEmail; $contactMessage; $message; $webPhone)
C_OBJECT:C1216($entity)

C_BOOLEAN:C305($enforceChange; $doNotify)
C_LONGINT:C283($warningDays; $changeFrequency; $daysToChange)
C_TEXT:C284($onHoldMessage; $mustChange; $mustChangeOnHold; $notApprovedMessage; $noWebAccess)
C_TEXT:C284($recommendChange; $technicalProblem; $userNotFound; $afterLoginAttempts; $loginAttempts)
C_TEXT:C284($noConfirmation)
C_OBJECT:C1216($entity)

$tContext:="customers"
READ ONLY:C145([Customers:3])
READ WRITE:C146([WebUsers:14])


If (True:C214)
	$contactMessage:=getKeyValue("web.customers.login.contact.alert")
	If ($contactMessage="")
		$contactMessage:="Please configure: web.customers.login.contact.alert"
	End if 
	
	$onHoldMessage:=getKeyValue("web.customers.login.onhold.alert")
	If ($onHoldMessage="")
		$onHoldMessage:=""
	End if 
	
	$notApprovedMessage:=getKeyValue("web.customers.login.notapproved.alert")
	If ($notApprovedMessage="")
		$notApprovedMessage:="Your account has not yet been approved."
	End if 
	
	$noWebAccess:=getKeyValue("web.customers.login.nowebaccess.alert")
	If ($noWebAccess="")
		$noWebAccess:="Your account is currently is not set up for web access."
	End if 
	
	$mustChange:=getKeyValue("web.customers.login.mustchange.alert")
	If ($mustChange="")
		$mustChange:="Please note you MUST change your password in "
	End if 
	
	$mustChangeOnHold:=getKeyValue("web.customers.login.mustchangeonhold.alert")
	If ($mustChangeOnHold="")
		$mustChangeOnHold:="Your account is on hold due to a required password change."
	End if 
	
	$recommendChange:=getKeyValue("web.customers.login.recommendchange.alert")
	If ($recommendChange="")
		$recommendChange:="Please note it is recommended that you change your password in "
	End if 
	
	$technicalProblem:=getKeyValue("web.customers.login.technical.alert")
	If ($technicalProblem="")
		$technicalProblem:="There is a technical problem with your account."
	End if 
	
	$userNotFound:=getKeyValue("web.customers.login.usernotfound.alert")
	If ($userNotFound="")
		$userNotFound:="Username Not Found, try again"
	End if 
	
	$afterLoginAttempts:=getKeyValue("web.customers.login.afterloginattempts.alert")
	If ($afterLoginAttempts="")
		$afterLoginAttempts:="After the next unsuccessful login attempt your account will be put on hold."
	End if 
	
	$loginAttempts:=getKeyValue("web.customers.login.loginattempts.alert")
	If ($loginAttempts="")
		$loginAttempts:="Due to unsuccessful login attempts your account has been put on hold."
	End if 
	
	$noConfirmation:=getKeyValue("web.customers.login.noconfirmation.alert")
	If ($noConfirmation="")
		$noConfirmation:="Your account has not been confirmed yet. Please go to the confirmation page and enter the token emailed to you."
	End if 
End if 


// Login with user name or email entered in webUsername Field

webUsername:=strRemoveSpaces(WAPI_getParameter("webusername"))
webPassword:=strRemoveSpaces(WAPI_getParameter("webpassword"))

$entity:=ds:C1482.WebUsers.query("webUsername == :1  AND Password IS :2 AND isEmailConfirmed == :3 AND isLocked == :4"; webUsername; webPassword; True:C214; False:C215)
If ($entity.length=0)
	$entity:=ds:C1482.WebUsers.query("Email IS :1  AND Password IS :2 AND isEmailConfirmed == :3 AND isLocked == :4"; webUsername; webPassword; True:C214; False:C215)  //are they logging in with email?
End if 

If ($entity.length=1)
	USE ENTITY SELECTION:C1513($entity)
	LOAD RECORD:C52([WebUsers:14])
	
	//webUsername:=[WebUsers]webUsername  //just in case used email to log in
	
	// Reset the Password incorrect counter because the login was OK
	[WebUsers:14]incorrectPasswordCount:4:=0
	
	If ([WebUsers:14]lastLoginDate:15=Current date:C33(*))
		$doNotify:=False:C215
	Else 
		$doNotify:=True:C214
		[WebUsers:14]lastLoginDate:15:=Current date:C33(*)
	End if 
	[WebUsers:14]lastLoginTime:16:=Current time:C178(*)
	
	If ([WebUsers:14]passwordChangeDate:18=!00-00-00!)
		[WebUsers:14]passwordChangeDate:18:=Current date:C33(*)-1
	End if 
	
	$warningDays:=Num:C11(getKeyValue("web.configuration.password.warningdays"))
	$changeFrequency:=Num:C11(getKeyValue("web.configuration.password.changefrequency"))
	$daysToChange:=$changeFrequency-(Current date:C33(*)-[WebUsers:14]passwordChangeDate:18)
	$enforceChange:=getKeyValue("web.configuration.password.enforcechange")="true"
	
	SAVE RECORD:C53([WebUsers:14])
	
	// Create or update the session
	C_TEXT:C284($sessionId)
	$sessionId:=WEB Get current session ID:C1162
	
	WAPI_createSession($sessionId)
	WAPI_authorizeSession
	WAPI_setSession("username"; [WebUsers:14]webUsername:1)
	WAPI_setSession("context"; $tContext)
	WAPI_setSession("email"; [WebUsers:14]Email:3)
	WAPI_setSession("login"; "false")
	WAPI_setSession("isAuthorized"; "false")
	
	webLoginCreateLog
	
	//$iFound:=-1
	$tCustomerID:=""
	$tWebEmail:=[WebUsers:14]Email:3
	$webPhone:=[WebUsers:14]phone:19
	
	UNLOAD RECORD:C212([WebUsers:14])
	
	
	If (True:C214)
		$entity:=ds:C1482.Customers.query("Email IS :1"; $tWebEmail)
		If ($entity.length=1)
			USE ENTITY SELECTION:C1513($entity)
			LOAD RECORD:C52([Customers:3])
		Else 
			$entity:=ds:C1482.Customers.query("CellPhone == :1 OR WorkTel == :1 OR HomeTel == :1 OR BusinessPhone1 == :1 OR BusinessPhone2 == :1"; $webPhone)
			If ($entity.length=1)
				If ($entity.first().approvalStatus=1)  //approved but doenst have a email link so not good
					REDUCE SELECTION:C351([Customers:3]; 0)
				Else 
					//not approved so this might be valid
					USE ENTITY SELECTION:C1513($entity)
					LOAD RECORD:C52([Customers:3])
				End if 
			Else 
				REDUCE SELECTION:C351([Customers:3]; 0)
			End if 
			
		End if 
	End if 
	
	Case of 
			
		: (Records in selection:C76([Customers:3])=0) & ([WebUsers:14]requestDate:21=!00-00-00!)
			WAPI_setAlertMessage("Login correct, Please setup your initial profile."; 1)
			CREATE RECORD:C68([Customers:3])
			[Customers:3]Email:17:=[WebUsers:14]Email:3
			Case of 
				: ([WebUsers:14]phoneType:20="Cell")
					[Customers:3]CellPhone:13:=[WebUsers:14]phone:19
				: ([WebUsers:14]phoneType:20="Home")
					[Customers:3]HomeTel:6:=[WebUsers:14]phone:19
				: ([WebUsers:14]phoneType:20="Work")
					[Customers:3]WorkTel:12:=[WebUsers:14]phone:19
				Else 
					[Customers:3]CellPhone:13:=[WebUsers:14]phone:19
			End case 
			
			WAPI_sendFile("profile-create.shtml"; $tContext)
			
			
		: (Records in selection:C76([Customers:3])=0)  //12/12/20
			WAPI_setAlertMessage("Customer support has been notified of your request."+" <br>"+$contactMessage+" [-9980]"; 3; False:C215)
			webSendLoginPage
			
			If ($doNotify)  // only once a day
				//alert email to customer service
				WAPI_setParameter("email-template"; "alert-existing-profile-request.html")
				WAPI_setParameter("email-subject"; "Customer Profile Match NOT found - Please Research: "+[WebUsers:14]Email:3)
				webNotification
			End if 
			
			
		: (Records in selection:C76([Customers:3])=1)
			
			If ([Customers:3]approvalStatus:146=1)
				WAPI_setSession("isAuthorized"; "true")
			End if 
			
			Case of 
					//0=UNKNOWN; 1=APPROVED; 2=PENDING EXISTING; 3=PENDING NEW; 4=REJECTED
					
				: ([Customers:3]approvalStatus:146<=0) | ([Customers:3]approvalStatus:146>4)  //not yet handled UKNOWN- set to not approved for agent to find - redirect to let them know to call 
					//SHOULD NOT BE LESS THAN OR GREATER THAN BUT TRAP HERE
					UNLOAD RECORD:C212([Customers:3])
					READ WRITE:C146([Customers:3])
					LOAD RECORD:C52([Customers:3])
					[Customers:3]approvalStatus:146:=2
					SAVE RECORD:C53([Customers:3])
					
					WAPI_setAlertMessage($notApprovedMessage+" <br>"+$contactMessage+" [-9981]"; 3; False:C215)
					webSendLoginPage
					
					UNLOAD RECORD:C212([Customers:3])
					REDUCE SELECTION:C351([Customers:3]; 0)
					
					If ($doNotify)  // only once a day
						//alert email to customer service
						WAPI_setParameter("email-template"; "alert-existing-profile-request.html")
						WAPI_setParameter("email-subject"; "Existing Customer web approval request: "+[WebUsers:14]Email:3)
						webNotification
					End if 
					
				: ([Customers:3]approvalStatus:146=2) | ([Customers:3]approvalStatus:146=3)  //not approved yet - redirect to let them know to call 
					//2=existing customer 3=new customer
					WAPI_setAlertMessage($notApprovedMessage+"<br>"+$contactMessage+" [-9982]"; 3; False:C215)
					//webSendLoginPage 
					
					WAPI_setSession("login"; "true")  //isAuthorized = False so won't have access to transactions
					WAPI_setSession("customerid"; [Customers:3]CustomerID:1)
					webSendWelcomePage
					
					
					If ($doNotify)  // only once a day
						//alert email to customer service
						WAPI_setParameter("email-template"; "alert-existing-profile-request.html")
						WAPI_setParameter("email-subject"; "Customer web access approval request: "+[WebUsers:14]Email:3)
						webNotification
					End if 
					
				: ([Customers:3]approvalStatus:146=4)  //rejected
					WAPI_setAlertMessage($notApprovedMessage+"<br>"+$contactMessage+" [-9982x]"; 3; False:C215)
					webSendLoginPage
					
				: ([Customers:3]isOnHold:52)  // redirect to let them know
					WAPI_setAlertMessage($onHoldMessage+"<br>"+$contactMessage+" [-9983]"; 3; False:C215)
					webSendLoginPage
					
				: ([Customers:3]isAllowedInternetAccess:50=False:C215)
					WAPI_setAlertMessage($noWebAccess+"<br>"+$contactMessage+" [-9984]"; 3; False:C215)
					webSendLoginPage
					
				: ([Customers:3]approvalStatus:146=1) & ([WebUsers:14]relatedTable:8=Table:C252(->[Customers:3])) & ([WebUsers:14]recordID:9="")
					//APPROVED -  ACCOUNT NOT "LINKED"  MAKE THEM CONFIRM
					UNLOAD RECORD:C212([Customers:3])
					REDUCE SELECTION:C351([Customers:3]; 0)
					WAPI_sendFile("profile-confirm.shtml"; $tContext)
					
				: ([WebUsers:14]relatedTable:8=Table:C252(->[Customers:3])) & ([WebUsers:14]recordID:9#[Customers:3]CustomerID:1)  //not a correct link
					WAPI_setAlertMessage($technicalProblem+"<br>"+$contactMessage+" [-9985]"; 4; False:C215)
					webSendLoginPage
					
				: ([WebUsers:14]relatedTable:8#Table:C252(->[Customers:3])) & ([WebUsers:14]recordID:9=[Customers:3]CustomerID:1)  //not a correct link
					WAPI_setAlertMessage($technicalProblem+"<br>"+$contactMessage+" [-9986]"; 4; False:C215)
					webSendLoginPage
					
					
				: ($daysToChange<=0) & ($enforceChange)
					READ WRITE:C146([Customers:3])
					LOAD RECORD:C52([Customers:3])
					[Customers:3]isOnHold:52:=True:C214
					[Customers:3]AML_OnHoldNotes:127:=[Customers:3]AML_OnHoldNotes:127+"Required web password change."
					SAVE RECORD:C53([Customers:3])
					UNLOAD RECORD:C212([Customers:3])
					REDUCE SELECTION:C351([Customers:3]; 0)
					
					WAPI_setAlertMessage($mustChangeOnHold+"<br>"+$contactMessage+" [-9987]"; 4; False:C215)
					webSendLoginPage
					
				: ($changeFrequency>0) & ($daysToChange<=$warningDays)
					If ($enforceChange)
						WAPI_setAlertMessage($mustChange+String:C10($daysToChange)+" days."; 3)
					Else 
						WAPI_setAlertMessage($recommendChange+String:C10($daysToChange)+" days."; 2)
					End if 
					
					WAPI_setSession("login"; "true")
					WAPI_setSession("customerid"; [Customers:3]CustomerID:1)
					webSendWelcomePage
					
				Else 
					$message:=getKeyValue("web.customers.welcome.alert")
					If ($message="")
						WAPI_setAlertMessage("Login correct, Welcome"; 1)
					Else 
						WAPI_setAlertMessage($message; 1)
					End if 
					
					WAPI_setSession("login"; "true")
					WAPI_setSession("customerid"; [Customers:3]CustomerID:1)
					webSendWelcomePage
			End case 
			
			
		Else   //> 1 customer found - should not happen
			WAPI_setAlertMessage("Your account is currently UNAVAILABLE.<br>"+$contactMessage+" [-9989]"; 3; False:C215)
			webSendLoginPage
			
	End case 
	
	
Else   //not found
	
	$entity:=ds:C1482.WebUsers.query("webUsername == :1  AND Password IS :2 "; webUsername; webPassword)
	If ($entity.length=0)
		$entity:=ds:C1482.WebUsers.query("Email IS :1  AND Password IS :2 "; webUsername; webPassword)  //are they logging in with email?
	End if 
	
	If ($entity.length=1)
		USE ENTITY SELECTION:C1513($entity)
		LOAD RECORD:C52([WebUsers:14])
		
		If ([WebUsers:14]isEmailConfirmed:12) & ([WebUsers:14]isLocked:10=False:C215)
			[WebUsers:14]incorrectPasswordCount:4:=[WebUsers:14]incorrectPasswordCount:4+1
			SAVE RECORD:C53([WebUsers:14])
		End if 
		
		Case of 
			: ([WebUsers:14]isEmailConfirmed:12=False:C215)
				$webErrorMessage:=$noConfirmation
				$webMessageType:=3
				
			: ([WebUsers:14]incorrectPasswordCount:4=2)
				$webErrorMessage:=$afterLoginAttempts
				$webMessageType:=3
				
			: ([WebUsers:14]incorrectPasswordCount:4>=3)
				[WebUsers:14]isLocked:10:=True:C214
				[WebUsers:14]confirmationToken:6:=generateRandomString(12)
				SAVE RECORD:C53([WebUsers:14])
				webSendAccountOnHoldEmail([WebUsers:14]Email:3)
				
				$webErrorMessage:=$loginAttempts+"<br>"+$contactMessage
				$webMessageType:=4
				
			Else 
				If ([WebUsers:14]isLocked:10)
					$webErrorMessage:=$onHoldMessage+" <br>"+$contactMessage
					$webMessageType:=4
					
				Else 
					$webErrorMessage:="Login incorrect, try again"
					$webMessageType:=4
				End if 
				
		End case 
		
	Else 
		
		$entity:=ds:C1482.WebUsers.query("webUsername == :1"; webUsername)
		If ($entity.length=0)
			$entity:=ds:C1482.WebUsers.query("Email IS :1"; webUsername)
		End if 
		
		If ($entity.length=1)
			$webErrorMessage:="Incorrect password"  //"password wrong
			$webMessageType:=4
		Else 
			$webErrorMessage:=$userNotFound  //"Username Not Found, try again"
			$webMessageType:=4
		End if 
	End if 
	
	WAPI_setAlertMessage($webErrorMessage; $webMessageType; False:C215)
	webSendLoginPage  //($tContext)
End if 

UNLOAD RECORD:C212([WebUsers:14])
READ ONLY:C145([WebUsers:14])
LOAD RECORD:C52([WebUsers:14])
