//%attributes = {"publishedWeb":true}
C_LONGINT:C283($webMessageType)
C_TEXT:C284($tEmail; $webErrorMessage; $tToken)
C_OBJECT:C1216($entity; $status)

$tToken:=WAPI_getParameter("webConfirmationToken")
$tEmail:=WAPI_getParameter("webEmail")


$entity:=New object:C1471
$entity.length:=0
$entity:=ds:C1482.WebUsers.query("Email IS :1 AND confirmationToken IS :2"; $tEmail; $tToken)

If ($entity.length=1)  // found webuser
	C_OBJECT:C1216($webuser)
	$webuser:=$entity.first()
	
	$webuser.isTokenConfirmed:=True:C214
	$webuser.isEmailConfirmed:=True:C214
	$webuser.confirmationToken:=""
	$status:=$webuser.save()
	
	If ($status.success)
		//check to see if existing customer record
		$entity:=ds:C1482.Customers.query("Email IS :1"; $tEmail)
		
		If ($entity.length=1)
			C_OBJECT:C1216($customer)
			$customer:=$entity.first()
			
			Case of 
				: ($customer.approvalStatus=1)  //approved already
					$webErrorMessage:=getKeyValue("web.customers.profile.status.approved.alert"; "Your profile is approved. You can now use the web portal")
					
				: ($customer.approvalStatus=0)  //unknown
					$customer.approvalStatus:=2
					$status:=$customer.save()
					If ($status.success)
						$webErrorMessage:=getKeyValue("web.customers.profile.status.pendingexisting.alert"; "Your profile is Pending approval. You will receive an email on approval.")
					Else 
						
					End if 
					
					// send email to internal staff
					//alert email to customer service
					WAPI_setParameter("email-template"; "alert-existing-profile-request.html")
					WAPI_setParameter("email-subject"; "Existing Customer web approval request: "+$tEmail)
					webNotification
					
				: ($customer.approvalStatus=2)  //not approved existing
					$webErrorMessage:=getKeyValue("web.customers.profile.status.pendingexisting.alert"; "Your profile is Pending approval. You will receive an email on approval.")
					
					// send email to internal staff
					//alert email to customer service
					WAPI_setParameter("email-template"; "alert-existing-profile-request.html")
					WAPI_setParameter("email-subject"; "Existing Customer web approval request: "+$tEmail)
					webNotification
					
					
				: ($customer.approvalStatus=3)  // not approved new
					//shouldn't get here ever
			End case 
			
		Else   //no customer record
			$webErrorMessage:=getKeyValue("web.customers.profile.status.pendingnew.alert"; "Please log in to finish creating your profile.")
		End if 
		
		// TODO: Get First and last Name from the table Customers?
		webFirstName:=""
		webLastName:=""
		webEmail:=""
		
		WAPI_setAlertMessage($webErrorMessage; 1)
		webSendRegistrationSuccess
		
	Else 
		$webErrorMessage:="There was an error confirming your token. Please try again later."
		$webMessageType:=4
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		webSendEmailConfirmationFailed
	End if 
	
	
	
Else 
	
	// Check if account is on hold
	$entity:=ds:C1482.WebUsers.query("Email IS :1"; $tEmail)
	
	If ($entity.length=1)
		
		Case of 
			: ($entity.first().isLocked)
				$webErrorMessage:="<b>Your account is on hold</b>. You cannot confirm your email. Contact support."
				$webMessageType:=4
				WAPI_setAlertMessage($webErrorMessage; $webMessageType)
				webEmail:=""
				webSendConfirmTokenPage
				
			: ($entity.first().isTokenConfirmed)  //already confirmed
				$webErrorMessage:="<b>Your account is confirmed</b>. Please log in to continue."
				$webMessageType:=4
				WAPI_setAlertMessage($webErrorMessage; $webMessageType)
				webEmail:=""
				webSendRegistrationSuccess
				
			Else 
				webFirstName:=""
				webLastName:=""
				
				$webErrorMessage:="<b>The Registration Code was NOT confirmed</b>. Please try again or contact customer support."
				$webMessageType:=4
				WAPI_setAlertMessage($webErrorMessage; $webMessageType)
				webSendEmailConfirmationFailed
				
		End case 
		
	Else 
		webFirstName:=""
		webLastName:=""
		
		$webErrorMessage:="<b>The email address was NOT found</b>. Please try again or contact customer support."
		$webMessageType:=4
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		webSendEmailConfirmationFailed
	End if 
	
	
End if 


//UNLOAD RECORD([WebUsers])
//READ ONLY([WebUsers])
//REDUCE SELECTION([WebUsers];0)
