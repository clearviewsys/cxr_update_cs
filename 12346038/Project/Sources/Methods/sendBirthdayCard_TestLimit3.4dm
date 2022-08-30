//%attributes = {}
// sendBirthdayCard
// this method runs in Calendar events once a day to check who are the customer that have a birthday and create a notification record

C_TEXT:C284($email; $body; $subject; $emailAddress; $tFilePath; $isProductionMode)
C_OBJECT:C1216($customers; $customer; $emailExist; $formula)
C_LONGINT:C283($i; $0)
C_COLLECTION:C1488($testEmails)
// check customers with todays birthday
READ ONLY:C145([Customers:3])
SET QUERY LIMIT:C395(3)
QUERY BY FORMULA:C48([Customers:3]; (([Customers:3]Email:17#"") & ([Customers:3]isCompany:41=False:C215) & (Month of:C24([Customers:3]DOB:5)=Month of:C24(Current date:C33(*))) & (Day of:C23([Customers:3]DOB:5)=Day of:C23(Current date:C33(*)))))
SET QUERY LIMIT:C395(0)
$testEmails:=New collection:C1472
$testEmails.push("test@clearviewsys.com"; "test2@clearviewsys.com"; "viktor@clearviewsys.com")
$subject:=getKeyValue("email.greetings.birthday.subject"; "Happy Birthday!")
C_TEXT:C284($birthdayImagePath)
$birthdayImagePath:=getFilePathByID("BirthdayGreeting")
If ($birthdayImagePath#"")
	
	
	For ($i; 1; Records in selection:C76([Customers:3]))
		// check if bday greeting created already
		GOTO SELECTED RECORD:C245([Customers:3]; $i)
		//[Customers]Email:=$testEmails[$i-1]
		//SAVE RECORD([Customers])
		$email:=$testEmails[$i-1]
		//$email:=[Customers]Email
		//If (Current user="Designer") | (<>CLIENTCODE="Xchange@")  // just for testing to make sure to not accidentally send the email to a valid email address
		$isProductionMode:=getKeyValue("email.greetings.birthday.production.mode"; "true")
		//If (Lowercase($isProductionMode)="false")
		//$email:="noreply@clearviewsys.com"
		//End if 
		//$emailExist:=ds.Notifications.query("message.to =:1 & message.subject =:2 & message.creationDate<=:3 & message.creationDate>:4";$email;$subject;Current date(*);Add to date(Current date(*);0;0;-300))
		//If ($emailExist.length<=0)
		If (True:C214)
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