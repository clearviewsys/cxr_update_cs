//%attributes = {}
C_TEXT:C284($email; $body)
C_LONGINT:C283($error)
$email:=[Customers:3]Email:17

If ($email="")
	myAlert("We don't have an email for this customer.")
End if 
$email:=Request:C163("Send email to:"; $email; "Send Email"; "Cancel")
If ((OK=1) & ($email#""))
	
	$body:=makeEmailBodyFromInvoice
	
	If (OK=1)
		If (getKeyValue("invoice.email")="alert")  // the old fashion way
			$error:=sendEmailUsingServerSettings($email; "Invoice "+[Invoices:5]InvoiceID:1; $body)
			If ($error=0)
				myAlert("Email sent"+CRLF+$body)
			Else 
				myAlert("Email could not be sent.")
			End if 
		Else   // send the email using notification
			sendNotificationByEmail($email; "Receipt "+[Invoices:5]InvoiceID:1; $body)
			notifyAlert("Notification"; "Email Queued for sending. Check the Notifications module to track Status"; 3)
		End if 
		
	End if 
	
End if 