//%attributes = {}
C_TEXT:C284($1; $email)

C_TEXT:C284($body; $subject; $email)
C_LONGINT:C283($i; $iError)
C_OBJECT:C1216($options)
C_COLLECTION:C1488($attachment)
C_TEXT:C284($file)

If (Count parameters:C259>=1)
	$email:=$1
End if 

If ($email="")
	$email:=Request:C163("email address"; [Customers:3]Email:17; "Email"; "Cancel")
Else 
	OK:=1
End if 

$file:=printThisInvoiceAsPDF

//SHOW ON DISK($file)
//.If ([Customers]Email="")

$body:=makeEmailBodyFromInvoice
$subject:="Invoice "+[Invoices:5]InvoiceID:1


If (OK=1)
	$options:=New object:C1471
	$options.URL:=""  // "smtp://"+"mail.4d.rs"
	$options.PORT:=0  //587
	$options.USERNAME:=""  //"info@4d.rs"
	$options.PASSWORD:=""  //"Sr11Ma26"
	$options.MAIL_FROM:=""  //"info@4d.rs"
	$options.PASSWORD:=""
	
	$options.MAIL_RCPT:=$email
	$options.BODY:=$body
	$options.SUBJECT:=$subject
	
	$attachment:=New collection:C1472
	$attachment.push($file)
	
	QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252(->[Invoices:5]); *)
	QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=[Invoices:5]InvoiceID:1)
	
	
	For ($i; 1; Records in selection:C76([LinkedDocs:4]))
		
		If (Picture size:C356([LinkedDocs:4]ScannedImage:2)>0)
			
			Case of 
				: ([LinkedDocs:4]DocReference:6#"")
					$file:=Temporary folder:C486+Replace string:C233([LinkedDocs:4]DocReference:6; " "; "")+".jpg"
					
				: ([LinkedDocs:4]TypeOfDoc:5#"")
					$file:=Temporary folder:C486+Replace string:C233([LinkedDocs:4]TypeOfDoc:5; " "; "")+".jpg"
					
				Else 
					$file:=Temporary folder:C486+DATE_getCurrentDTS+".jpg"
			End case 
			
			WRITE PICTURE FILE:C680($file; [LinkedDocs:4]ScannedImage:2; ".jpg")
			
			$attachment.push($file)
			
		End if 
		
		NEXT RECORD:C51([LinkedDocs:4])
	End for 
	
	$iError:=sendEmailviacURL($options; $attachment)
	
	If ($iError=0)
		notifyAlert("Email"; "Email sent successfully"; 5)
	Else 
		notifyAlert("Email Error"; String:C10($iError))
	End if 
	
End if 