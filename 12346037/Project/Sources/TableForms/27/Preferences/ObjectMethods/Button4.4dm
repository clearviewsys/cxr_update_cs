C_LONGINT:C283($vError)

checkInit
checkIfNullString(->[ServerPrefs:27]smtpServer:5; "SMTP Server")
checkIfNullString(->[ServerPrefs:27]smtpFromEmail:6; "SMTP Email Address")
//checkIfNullString (->[ServerSettings]smtpUserName;"SMTP User Name";"warn")
checkIfNullString(->[ServerPrefs:27]administratorEmail:12; "You need to provide an 'Admin Email' to be able to test the mail")

If (isValidationConfirmed)
	$vError:=sendEmailUsingServerSettings([ServerPrefs:27]administratorEmail:12; "Testing SMTP Setting from CurrencyXchanger"; "Since you received this email, your SMTP settings are correct and your test was s"+"ucc"+"essful.")
	ALERT:C41("Please check the email box of your administrator "+[ServerPrefs:27]administratorEmail:12+". ")
End if 
