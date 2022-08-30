//%attributes = {}
// sendBirthdayCardTest
// test in sending birthday card

C_TEXT:C284($tTestEmail)

$tTestEmail:=Request:C163("Please enter the email address to send test birthday email")
If ($tTestEmail="") & (OK=1)
	myAlert("Please enter email address")
Else 
	If (Ok=1)
		C_TEXT:C284($email; $body; $subject; $emailAddress; $tFilePath)
		C_OBJECT:C1216($customers; $customer; $emailExist; $formula)
		$subject:=getKeyValue("email.greetings.birthday.subject"; "Happy Birthday!")  //Allow customer to set Subject of bday email with KeyValue
		C_TEXT:C284($birthdayImagePath)
		$birthdayImagePath:=getFilePathByID("BirthdayGreeting")
		If ($birthdayImagePath="")
			myAlert("No birthday image file path found. Please create BirthdayGreeting file path.")
		Else 
			// check if bday greeting created already
			$email:=$tTestEmail
			$tFilePath:=getEmailTemplateFolder+"email-happy-birthday.html"
			If (Test path name:C476($tFilePath)=Is a document:K24:1)
				$body:=Document to text:C1236($tFilePath)
				PROCESS 4D TAGS:C816($body; $body)
				If (OK=1)
					sendNotificationByEmail($email; $subject; $body; New collection:C1472($birthdayImagePath))
					myAlert("Email created and will be sent within 3 minutes. ")
				End if 
			Else 
				UTIL_Log(Current method name:C684; "Template NOT Found: "+$tFilePath)
				myAlert("No birthday template found. Please contact Clear View Systems.")
			End if 
			
		End if 
	End if 
	
End if 