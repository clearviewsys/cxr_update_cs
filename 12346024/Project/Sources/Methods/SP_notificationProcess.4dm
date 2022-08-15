//%attributes = {}


// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 06/14/20, 09:41:28
// ----------------------------------------------------
// Method: SP_notificationProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_BOOLEAN:C305($1)

C_LONGINT:C283($0; $iProcess)

C_LONGINT:C283($iProcess; $status; $attempts; $error)
C_REAL:C285($Minutes)
C_TEXT:C284($processName; $errorMessage)
C_OBJECT:C1216($entitySelection; $entity; $response)
C_TEXT:C284($email; $subject; $body)
C_COLLECTION:C1488($col)

$processName:="notificationProcess"
$iProcess:=Process number:C372($processName)

ON ERR CALL:C155("SP_onError")

Case of 
	: ($iProcess=0)  //doesn't exist so start it up
		$iProcess:=New process:C317(Current method name:C684; 0; $processName; True:C214; *)
		BRING TO FRONT:C326($iProcess)
		
		
	: (Count parameters:C259=1)  //this is a new process so init
		
		$Minutes:=Num:C11(getKeyValue("notifications.config.sleeptime"; "1"))  //how long to sleep before checking again
		$status:=Num:C11(getKeyValue("notifications.config.sendstatus"; "0"))  //0  //pending
		$attempts:=Num:C11(getKeyValue("notifications.config.attempts"; "3"))  //3  //try this many times before giving up
		
		Repeat 
			
			//$entitySelection:=ds.Notifications.query("status == :1 and response.failedAttempts <=:2 and message.message #:3";$status;3;Null)
			$entitySelection:=ds:C1482.Notifications.query("status == :1 OR (response.failedAttempts <=:2 AND status#1)"; $status; $attempts)
			
			If ($entitySelection.length>0)
				//loop thru and send notification
				For each ($entity; $entitySelection)
					If (($entity.response.failedAttempts<=$attempts) | ($entity.response.failedAttempts=Null:C1517))
						
						Case of 
								//: ([Notifications]type=1)  //email
							: ($entity.type=1)
								
								$error:=0
								
								$col:=New collection:C1472
								$col:=Split string:C1554($entity.message.to; ","; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
								
								For each ($email; $col) While ($error=0)
									$email:=strRemoveSpaces($email)
									
									Case of 
										: ($entity.message.message="@CID:embedded@") & ($entity.message.attachments#Null:C1517)  // with content id referring to the embedded image
											$error:=sendEmailviaSMTP($email; $entity.message.subject; $entity.message.message; $entity.message.attachments)
										: ($entity.message.attachments#Null:C1517)
											$error:=sendEmailUsingServerSettings($email; $entity.message.subject; $entity.message.message; $entity.message.attachments)
										Else 
											$error:=sendEmailUsingServerSettings($email; $entity.message.subject; $entity.message.message)
									End case 
									
									//<>TODO lookup error number and set $errorMessage ??
									$errorMessage:=""
									
								End for each 
								
								//: ([Notifications]type=2)  //sms
							: ($entity.type=2)
								If ($entity.message.to#"")
									$errorMessage:=""
									//$pError:=->$errorMessage
									$error:=Num:C11(twilioSendSMS(->$errorMessage; $entity.message.to; $entity.message.message))
								Else 
									$error:=-2
								End if 
								
								Case of 
									: ($error=200)  //success
										$error:=0
									: ($error=400)  //not enough money - send email to alert someone?
										//TRACE
										//sendNotificationByEmail ("barclay@clearviewsys.com";"Twilio needs money";"please add funds")  //testing
									Else 
										//just relay the error number and message from twilio
								End case 
								
								
								//: ([Notifications]type=3)  //hola
							: ($entity.type=3)
								
							Else 
								//unknown
								$error:=-9999
						End case 
						
						
						Case of 
							: ($error=0)
								//not sure what else in the $entity.response object needs updating
								$entity.response.status:="Success"
								$entity.response.code:=$error
								$entity.response.date:=Current date:C33
								$entity.response.time:=Current time:C178
								$entity.status:=1
								$response:=$entity.save()
								
							: ($error=-9999)  //unknown type
								$entity.response.status:="UNKNOWN TYPE"
								$entity.response.failedAttempts:=$attempts+1  //DONT TRY AGAIN
								$entity.response.code:=$error
								$entity.response.date:=Current date:C33
								$entity.response.time:=Current time:C178
								$entity.status:=-9999
								$response:=$entity.save()
								
							: ($entity.response.failedAttempts<$attempts)  //12/15/20 @IBB
								$entity.response.status:="Pending"
								$entity.response.code:=$error
								$entity.response.date:=Current date:C33
								$entity.response.time:=Current time:C178
								$entity.status:=0  //still pending
								$entity.response.failedAttempts:=$entity.response.failedAttempts+1
								$response:=$entity.save()
								
							Else   //failed to send 
								//not sure what else in the $entity.response object needs updating
								$entity.response.status:="Failed"
								$entity.response.failedAttempts:=$entity.response.failedAttempts+1
								$entity.response.message:=$errorMessage
								$entity.response.code:=$error
								$entity.response.date:=Current date:C33
								$entity.response.time:=Current time:C178
								$entity.status:=-1
								$response:=$entity.save()
								
						End case 
						
						If ($response.success)
							//all good
						Else 
							UTIL_Log(Current method name:C684; "Error Saving [Notification]: "+[Notifications:158]ID:1+" : "+$response.statusText)
						End if 
						
						
					End if 
					
					
				End for each 
			End if 
			
			DELAY PROCESS:C323(Current process:C322; $Minutes*60*60)
		Until (<>SP_Stop)
		
		
	Else   //this is existing so update
		BRING TO FRONT:C326($iProcess)
End case 



$0:=$iProcess