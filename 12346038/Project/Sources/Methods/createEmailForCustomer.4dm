//%attributes = {}
//createEmailForCustomer

C_TEXT:C284($email; $body; $subject; customerFirstMessage; customerTableChange; customerLastMessage; customerSalutation)
C_LONGINT:C283($0; $error)

C_BOOLEAN:C305($honorChange; $confirmChange)
C_OBJECT:C1216($entity)
C_TEXT:C284($tFilePath)
C_LONGINT:C283($iCounter)

ARRAY TEXT:C222($atOldValue; 0)
ARRAY TEXT:C222($atNewValue; 0)
C_POINTER:C301($1; $2)

COPY ARRAY:C226($1->; $atOldValue)
COPY ARRAY:C226($2->; $atNewValue)

$entity:=ds:C1482.Customers.query("CustomerID == :1"; [Customers:3]CustomerID:1)
$email:=$entity.first().Email
$email:="jonna@clearviewsys.com"  // for testing

If ($email="")
	$error:=-1
Else 
	customerSalutation:="Dear "+[Customers:3]FullName:40+","
	
	C_LONGINT:C283($numberofChanges; $iiCounter; $iCounter)
	$numberofChanges:=Size of array:C274($atNewValue)
	If ($numberofChanges=1)  // only one change
		customerFirstMessage:="You're account detail has changed from "+$atOldValue{1}+" to "+$atNewValue{1}+"."
	Else 
		customerFirstMessage:="You're account details has changed. Please see changes below: "+"\n\n"
		customerTableChange:="<table class=\"table table-striped\"><tr><th>Old Information</th><th>Updated Information</th></tr>"
		For ($iCounter; 1; Size of array:C274($atOldValue))
			customerTableChange:=customerTableChange+"<tr>"
			customerTableChange:=customerTableChange+"<td>"+$atOldValue{$iCounter}+"</td>"
			customerTableChange:=customerTableChange+"<td>"+$atNewValue{$iCounter}+"</td>"
			customerTableChange:=customerTableChange+"</tr>"
		End for 
		customerTableChange:=customerTableChange+"</table>"
	End if 
	customerLastMessage:="test"
	$tFilePath:=getEmailTemplateFolder+"customers-confirmation.html"
	
	If (Test path name:C476($tFilePath)=Is a document:K24:1)
		$body:=Document to text:C1236($tFilePath)
		PROCESS 4D TAGS:C816($body; $body)
		
		If (OK=1)
			$subject:="Customer Account Change"
			// create a notification record
			sendNotificationByEmail($email; $subject; $body)
		End if 
	Else 
		myAlert("Template NOT Found: "+$tFilePath)
	End if 
	
End if 

$0:=$error