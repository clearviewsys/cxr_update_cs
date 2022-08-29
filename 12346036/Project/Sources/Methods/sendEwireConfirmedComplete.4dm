//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/15/20, 10:46:17
// ----------------------------------------------------
// Method: sendEwireConfirmedComplete
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($entity; $o; $notifications)
C_TEXT:C284($subject; $email)
C_BOOLEAN:C305($sendEmailSender; $sendEmailBeneficiary; $hasBeneficiary; $hasSender)
C_LONGINT:C283($i)
C_TEXT:C284($tFilePath; $body; $senderEmail; $beneficiaryEmail)

READ WRITE:C146([eWires:13])

$entity:=ds:C1482.eWires.query("isSettled == :1 & ReceiveDate<=:2 & ReceiveDate>=:3 & WebEwireID#''"; True:C214; Current date:C33(*); Add to date:C393(Current date:C33(*); 0; 0; -7))

If ($entity.length>0)
	//loop thru and check the notification table to see if the notification has been sent.
	//if not sent ... send an email notificaiton
	
	USE ENTITY SELECTION:C1513($entity)
	For ($i; 1; Records in selection:C76([eWires:13]))
		GOTO SELECTED RECORD:C245([eWires:13]; $i)
		
		$notifications:=ds:C1482.Notifications.query("message.sourceTable =:1 & message.sourceId=:2 & message.sourceType=:3"; Table:C252(->[eWires:13]); [eWires:13]WebEwireID:123; "Complete")
		
		$sendEmailSender:=False:C215
		$hasSender:=(ds:C1482.Customers.query("CustomerID="+[eWires:13]Author:4).length>0)
		If ($hasSender)
			$senderEmail:=ds:C1482.Customers.query("CustomerID="+[eWires:13]Author:4).first().Email
			$sendEmailSender:=($notifications.query("message.to =:1 & status#-1"; $senderEmail).length=0)
		End if 
		
		$sendEmailBeneficiary:=False:C215
		$hasBeneficiary:=(ds:C1482.Links.query("LinkID="+[eWires:13]LinkID:8).length>0)
		If ($hasBeneficiary)
			$beneficiaryEmail:=ds:C1482.Links.query("LinkID="+[eWires:13]LinkID:8).first().email
			$sendEmailBeneficiary:=($notifications.query("message.to =:1 & status#-1"; $beneficiaryEmail).length=0)
		End if 
		
		
		If ($sendEmailSender) | ($sendEmailBeneficiary)
			Case of 
				: ([eWires:13]doTransferToBank:33)  //bank deposit
					$subject:="The WebEWire "+[eWires:13]WebEwireID:123+" has been processed."
				: ([eWires:13]toMOP_Code:114=getKeyValue("ewire.tomop.mobilewallet"; "N-M"))  //movible wallet
					$subject:="The WebEWire "+[eWires:13]WebEwireID:123+" has been processed."
				Else 
					$subject:="The WebEWire "+[eWires:13]WebEwireID:123+" has been received."
			End case 
			
			$tFilePath:=getEmailTemplateFolder+"ewire-confirmed-complete.html"
			If (Test path name:C476($tFilePath)=Is a document:K24:1)
				$body:=Document to text:C1236($tFilePath)
				PROCESS 4D TAGS:C816($body; $body)
				//Else 
				//$body:=
			End if 
			
			// Define parameters for sending an email
			$o:=New object:C1471
			$o.subject:=$subject
			$o.message:=$body
			$o.sourceTable:=Table:C252(->[eWires:13])
			$o.sourceId:=[eWires:13]WebEwireID:123
			$o.sourceType:="Complete"
			
			If ($sendEmailSender)
				$o.to:=$senderEmail
				sendNotificationObjectByEmail($o)
			End if 
			If ($sendEmailBeneficiary)
				$o.to:=$beneficiaryEmail
				//sendNotificationObjectByEmail ($o)
			End if 
			
		End if 
		
		
	End for 
End if 


UNLOAD RECORD:C212([eWires:13])
READ ONLY:C145([eWires:13])
REDUCE SELECTION:C351([eWires:13]; 0)

//**OLD WAY**
//USE ENTITY SELECTION($entity)
//For ($i;1;Records in selection([eWires]))
//GOTO SELECTED RECORD([eWires];$i)
//$email:=[eWires]senderEmail
//$subject:="The WebEWire "+[eWires]WebEwireID+" has been received."

//$tFilePath:=getEmailTemplateFolder +"ewire-confirmed-complete.html"
//If (Test path name($tFilePath)=Is a document)
//$body:=Document to text($tFilePath)
//PROCESS 4D TAGS($body;$body)
//  //Else 
//  //$body:=
//End if 

//$sendEmail:=(ds.Notifications.query("message.to =:1 & message.subject =:2";$email;$subject).length=0)

//If ($sendEmail)
//  //sendNotificationByEmail ($email;$subject;$body)
//End if 



