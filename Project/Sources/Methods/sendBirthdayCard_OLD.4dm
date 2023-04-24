//%attributes = {}
// sendBirthdayCard
// this method runs in Calendar events once a day to check who are the customer that have a birthday and create a notification record

C_TEXT:C284($email; $body; $subject; $emailAddress; $tFilePath; $isProductionMode)
C_OBJECT:C1216($customers; $customer; $emailExist; $formula)
// check customers with todays birthday
READ ONLY:C145([Customers:3])
QUERY BY FORMULA:C48([Customers:3]; (([Customers:3]Email:17#"") & ([Customers:3]isCompany:41=False:C215) & (Month of:C24([Customers:3]DOB:5)=Month of:C24(Current date:C33(*))) & (Day of:C23([Customers:3]DOB:5)=Day of:C23(Current date:C33(*)))))
$customers:=Create entity selection:C1512([Customers:3])
$subject:=getKeyValue("email.greetings.birthday.subject"; "Happy Birthday!")
C_TEXT:C284($birthdayImagePath)
$birthdayImagePath:=getFilePathByID("BirthdayGreeting")
If ($birthdayImagePath#"")
	For each ($customer; $customers)
		// check if bday greeting created already
		$email:=$customer.Email
		//If (Current user="Designer") | (<>CLIENTCODE="Xchange@")  // just for testing to make sure to not accidentally send the email to a valid email address
		$isProductionMode:=getKeyValue("email.greetings.birthday.production.mode"; "true")
		If (Lowercase:C14($isProductionMode)="false")
			$email:="viktor@clearviewsys.com"
		End if 
		$emailExist:=ds:C1482.Notifications.query("message.to =:1 & message.subject =:2 & message.creationDate<=3"; $emailAddress; $subject; Current date:C33(*))
		If ($emailExist.length<=0)
			$tFilePath:=getEmailTemplateFolder+"email-happy-birthday.html"
			If (Test path name:C476($tFilePath)=Is a document:K24:1)
				$body:=Document to text:C1236($tFilePath)
				PROCESS 4D TAGS:C816($body; $body)
				If (OK=1)
					sendNotificationByEmail($email; $subject; $body; New collection:C1472($birthdayImagePath); getKeyValue("email.greetings.birthday.from"; <>smtpFromEmail))
				End if 
			Else 
				UTIL_Log(Current method name:C684; "Template NOT Found: "+$tFilePath)
			End if 
		End if 
	End for each 
End if 

$0:=0

