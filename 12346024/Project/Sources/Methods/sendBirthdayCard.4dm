//%attributes = {}
// sendBirthdayCard
// this method runs in Calendar events once a day to check who are the customer that have a birthday and create a notification record
// Unit test is written @ViKtor

C_TEXT:C284($email; $body; $subject; $emailAddress; $tFilePath; $isProductionMode)
C_OBJECT:C1216($customers; $customer; $emailExist; $formula)
C_LONGINT:C283($i; $0)
// check customers with todays birthday
READ ONLY:C145([Customers:3])
QUERY BY FORMULA:C48([Customers:3]; (([Customers:3]Email:17#"") & ([Customers:3]isCompany:41=False:C215) & (Month of:C24([Customers:3]DOB:5)=Month of:C24(Current date:C33(*))) & (Day of:C23([Customers:3]DOB:5)=Day of:C23(Current date:C33(*)))))
QUERY SELECTION BY FORMULA:C207([Customers:3]; isCustomerOKToEmail)

$subject:=getKeyValue("email.greetings.birthday.subject"; "Happy Birthday!")
C_TEXT:C284($birthdayImagePath)
$birthdayImagePath:=getFilePathByID("BirthdayGreeting")
If ($birthdayImagePath#"")
	
	For ($i; 1; Records in selection:C76([Customers:3]))
		// check if bday greeting created already
		GOTO SELECTED RECORD:C245([Customers:3]; $i)
		$email:=[Customers:3]Email:17
		//If (Current user="Designer") | (<>CLIENTCODE="Xchange@")  // just for testing to make sure to not accidentally send the email to a valid email address
		$isProductionMode:=getKeyValue("email.greetings.birthday.production.mode"; "true")
		If (Lowercase:C14($isProductionMode)="false")
			$email:="noreply@clearviewsys.com"
		End if 
		$emailExist:=ds:C1482.Notifications.query("message.to =:1 & message.subject =:2 & message.creationDate<=:3 & message.creationDate>:4"; $email; $subject; Current date:C33(*); Add to date:C393(Current date:C33(*); 0; 0; -300))
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
	End for 
End if 

$0:=0