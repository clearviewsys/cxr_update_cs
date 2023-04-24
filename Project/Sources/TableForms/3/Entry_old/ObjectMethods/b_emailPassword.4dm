C_TEXT:C284($token; $webEmailAddress)

If (True:C214)
	C_OBJECT:C1216($entity; $status; $user)
	
	
	If ([Customers:3]Email:17="")
		myAlert("Please enter an email address that is linked to a [WebUser].")
	Else 
		$entity:=ds:C1482.WebUsers.query("Email IS :1 AND isEmailConfirmed == :2 AND isLocked == :3"; [Customers:3]Email:17; True:C214; False:C215)
		If ($entity.length=1)
			$token:=generateRandomString(8)
			$webEmailAddress:=[Customers:3]Email:17
			
			$user:=$entity.first()
			$user.isTokenConfirmed:=False:C215
			$user.confirmationToken:=$token
			$status:=$user.save()
			
			If ($status.success)
				webSendChangePasswordEmail($webEmailAddress; $token)
				myAlert("Password reset email will be sent to: "+$webEmailAddress+" when you save this customer.")
			Else 
				myAlert("Password reset email FAILED to b sent to: "+$webEmailAddress)
			End if 
			
			//READ WRITE([WebUsers])
			
			//QUERY([WebUsers];[WebUsers]Email=$webEmailAddress;*)
			//QUERY([WebUsers]; & ;[WebUsers]isEmailConfirmed=True;*)
			//QUERY([WebUsers]; & ;[WebUsers]isLocked=False)
			
			//If (Records in selection([WebUsers])=1)
			//[WebUsers]isTokenConfirmed:=False
			//[WebUsers]confirmationToken:=$token
			//SAVE RECORD([WebUsers])
			//webSendChangePasswordEmail ($webEmailAddress;$token)
			
			//$webErrorMessage:="We have sent a email to: <b> "+$webEmailAddress+"</b> with instructions to reset the password"
			//$webMessageType:=1
			
			//If (WAPI_getSession ("context")="")
			//WAPI_setSession ("context";Table name([WebUsers]relatedTable))
			//End if 
			
			//WAPI_setAlertMessage ($webErrorMessage;$webMessageType)
			//webSendChangePasswordPage 
			
			//Else 
			//$webErrorMessage:="The email address provided was NOT found: <b> "+$webEmailAddress+"</b> please correct and try again."
			//$webMessageType:=2
			
			//WAPI_setAlertMessage ($webErrorMessage;$webMessageType)
			//webSendForgotPasswordPage 
			//End if 
			
			//UNLOAD RECORD([WebUsers])
			//READ ONLY([WebUsers])
			//REDUCE SELECTION([WebUsers];0)
		End if 
	End if 
	
Else   //old
	checkInit
	checkIfNullString(->[Customers:3]obs_password:48; "Password cannot be empty")
	checkIfNullString(->[Customers:3]Email:17; "Please enter a valid email")
	checkAddWarning("The customer's password will be sent via email to "+[Customers:3]Email:17)
	
	C_TEXT:C284($body)
	If (isValidationConfirmed)
		$body:="Hello "+[Customers:3]FullName:40+","+Char:C90(LF ASCII code:K15:11)
		$body:=$body+"Your Login ID is: "+[Customers:3]CustomerID:1+Char:C90(LF ASCII code:K15:11)
		$body:=$body+"Your Password is: "+[Customers:3]obs_password:48+Char:C90(LF ASCII code:K15:11)
		$body:=$body+"You may login by going to : "+<>CompanyWebAddress
		C_LONGINT:C283($error)
		$error:=sendEmail([Customers:3]Email:17; "Confidential from "+<>companyName; $body)
		
		If ($error#0)
			myAlert("There was an error sending the email")
		End if 
		
	End if 
End if 