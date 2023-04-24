//If (Form event=On Clicked)
//  // getKeyValueDescription
//If (getKeyValue ("invoice.email")="PDF")  // new
//handleSendPDFemailFromInvoice 
//Else 
//handleSendEmailFromInvoice 
//End if 
//End if 

C_LONGINT:C283($success)

C_TEXT:C284($email)

$email:=Request:C163("Enter the email address(s) to send to:"; ds:C1482.Customers.query("CustomerID == :1"; [Invoices:5]CustomerID:2).first().Email; "Send"; "Cancel")

If ($email#"") & (OK=1)
	
	If (getKeyValue("invoice.email")="PDF")  // new
		handleSendPDFemailFromInvoice($email)
	Else 
		$success:=sendNotificationEmailForInvoice($email)
		
		If ($success=0)
			myAlert("The email will be sent shortly. ")
		Else 
			myAlert("Email not sent. Customer does not have a valid email address. Please update. ")
		End if 
	End if 
	
End if 