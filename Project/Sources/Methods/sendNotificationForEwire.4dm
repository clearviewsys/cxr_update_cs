//%attributes = {}

C_TEXT:C284($1; $email)


C_TEXT:C284($body; $subject)
C_LONGINT:C283($0; $error)  //[AgentAccounts]

C_BOOLEAN:C305($honorChange; $confirmChange)
C_OBJECT:C1216($entity)
C_TEXT:C284($tFilePath)
C_LONGINT:C283($error)

If (Count parameters:C259>=1)
	$email:=$1
Else 
	$entity:=ds:C1482.Customers.query("CustomerID == :1"; [Invoices:5]CustomerID:2)
	$email:=$entity.first().Email
End if 

$error:=0

If ($email="")
	$error:=-1
Else 
	
	
	
	$body:=getEmailTemplateBody("invoices-new-record.html"; ->[Invoices:5])  //WAPI_getSession ("context"))
	If ($body="")
		$body:=makeEmailBodyFromInvoice
	End if 
	
	If (OK=1)
		$entity:=New object:C1471
		$entity:=ds:C1482.WebEWires.query("paymentInfo.invoiceID == :1"; [Invoices:5]InvoiceID:1)
		If ($entity.length=1)
			$subject:="Your eWire transaction has been processed [1].  "
		Else 
			$subject:="Invoice  "+[Invoices:5]InvoiceID:1
		End if 
		
		sendNotificationByEmail($email; $subject; $body)
	Else 
		$error:=-2
	End if 
	
	
End if 

$0:=$error