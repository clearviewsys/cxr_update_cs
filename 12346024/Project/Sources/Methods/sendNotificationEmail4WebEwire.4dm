//%attributes = {}
//createEmailBooking

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
	$entity:=ds:C1482.Customers.query("CustomerID == :1"; [WebEWires:149]CustomerID:21)
	$email:=$entity.first().Email
End if 

$error:=0

If ($email="")
	$error:=-1
Else 
	//$tFilePath:=getEmailTemplateFolder +"webewire-confirmation.html"
	
	//If (Test path name($tFilePath)=Is a document)
	//$body:=Document to text($tFilePath)
	//PROCESS 4D TAGS($body;$body)
	//Else 
	//$body:="Your ewire request status has changed."
	//$body:=$body+Char(Carriage return)+Char(Carriage return)+"Old status: "+getWebEWireStatusText (Old([WebEWires]status))
	//$body:=$body+Char(Carriage return)+"New status: "+getWebEWireStatusText ([WebEWires]status)
	//$body:=$body+Char(Carriage return)+Char(Carriage return)+getKeyValue ("web.customers.login.contact.alert")
	//End if 
	
	$body:=getEmailTemplateBody("webewires-new-record.html"; ->[WebEWires:149])  //WAPI_getSession ("context"))
	If ($body="")
		$body:="Your ewire request status has changed."
		$body:=$body+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Old status: "+getWebEWireStatusText(Old:C35([WebEWires:149]status:16))
		$body:=$body+Char:C90(Carriage return:K15:38)+"New status: "+getWebEWireStatusText([WebEWires:149]status:16)
		$body:=$body+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+getKeyValue("web.customers.login.contact.alert")
	End if 
	
	
	If (OK=1)
		$subject:="eWire Update: "+[WebEWires:149]WebEwireID:1
		// create a notification table
		sendNotificationByEmail($email; $subject; $body)
	Else 
		$error:=-2
	End if 
	
	
End if 

$0:=$error