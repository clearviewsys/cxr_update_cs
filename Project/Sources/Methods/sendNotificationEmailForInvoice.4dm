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
	
	$body:=makeEmailBodyFromInvoice
	$subject:="Invoice  "+[Invoices:5]InvoiceID:1
	
	If (OK=1)
		$subject:=""
		
		$entity:=New object:C1471
		$entity:=ds:C1482.WebEWires.query("paymentInfo.invoiceID == :1"; [Invoices:5]InvoiceID:1)
		If ($entity.length=1)
			Case of 
				: ($entity[0].paymentInfo.bookingType="mg")
					$subject:="Your MoneyGram transaction has been processed.  "
					$body:=getEmailTemplateBody("invoices-new-record.html"; ->[Invoices:5])
					
				: ($entity[0].paymentInfo.bookingType="wire")
					$subject:="Your Wire transaction has been processed.  "
					$body:=getEmailTemplateBody("invoices-new-record.html"; ->[Invoices:5])
					
				: ($entity[0].paymentInfo.bookingType="ewire")  // handled in ewire save btn
					//$subject:="Your eWire transaction has been processed.  "
					//$body:=getEmailTemplateBody ("ewires-new-record.html";->[Invoices])
					$body:=""
					$subject:=""
					
				: (webEwiresIsMoneyGram($entity[0].WebEwireID))
					$subject:="Your MoneyGram transaction has been processed.  "
					$body:=getEmailTemplateBody("invoices-new-record.html"; ->[Invoices:5])
					
				Else 
					$body:=""
					$subject:=""
			End case 
		End if 
		
		If ($body="")  //don't send anything
		Else 
			$subject:="Invoice  "+[Invoices:5]InvoiceID:1
			sendNotificationByEmail($email; $subject; $body)
		End if 
		
	Else 
		$error:=-2
	End if 
	
	
End if 

$0:=$error