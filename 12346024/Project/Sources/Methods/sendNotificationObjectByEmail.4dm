//%attributes = {}
// sendNotificationobjectByEmail (to, subject, message, {attachments:collection} , from , CC, BCC)
C_OBJECT:C1216($1; $object)


C_TEXT:C284($to)  //to
C_TEXT:C284($subject)  //subject
C_TEXT:C284($message)  //message
C_COLLECTION:C1488($attachments)  //attachment paths inside the collection
C_TEXT:C284($from)
C_TEXT:C284($cc)
C_TEXT:C284($bcc)
C_LONGINT:C283($i)

If (Count parameters:C259=1)
	$object:=$1
Else 
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 



C_OBJECT:C1216($o)

$o:=New object:C1471

$o.messageType:="email"
$o.createByUser:=getSystemUserName
$o.creationDate:=Current date:C33(*)
$o.creationTime:=Current time:C178(*)

ARRAY TEXT:C222($atProperties; 0)
OB GET PROPERTY NAMES:C1232($object; $atProperties)

For ($i; 1; Size of array:C274($atProperties))
	$o[$atProperties{$i}]:=OB Get:C1224($object; $atProperties{$i})  //do i need is text?
End for 


If (OB Is defined:C1231($o; "to"))
	
	If (OB Is defined:C1231($o; "from"))
	Else 
		$from:=<>smtpFromEmail  //system from
	End if 
	
	If (OB Is defined:C1231($o; "subject"))
	Else 
		$subject:="CXR notification"
	End if 
	
	If (OB Is defined:C1231($o; "message"))
	Else 
		$subject:="CXR notification: message undefined."
	End if 
	
	If ($o.to="")  //dont create
	Else 
		$o.to:=strRemoveSpaces($o.to)
		
		If (True:C214)
			CREATE RECORD:C68([Notifications:158])
			[Notifications:158]UUID:2:=Generate UUID:C1066
			[Notifications:158]type:3:=1  //email
			[Notifications:158]message:4:=$o
			OBJ_newResponse(->[Notifications:158]response:5)
			[Notifications:158]response:5.failedAttempts:=0
			[Notifications:158]response:5.code:=0
			[Notifications:158]status:6:=0
			[Notifications:158]creationDate:7:=Current date:C33(*)
			SAVE RECORD:C53([Notifications:158])
			
			UNLOAD RECORD:C212([Notifications:158])
			REDUCE SELECTION:C351([Notifications:158]; 0)
		Else 
			C_OBJECT:C1216($notification)
			$notification:=ds:C1482.Notifications.new()
			//$notification.ID:=makeNotificationsID 
			$notification.UUID:=Generate UUID:C1066
			$notification.type:=1  //Email
			$notification.message:=$o
			C_OBJECT:C1216($response)
			$response:=New object:C1471
			OBJ_newResponse(->$response)
			
			$notification.response:=$response
			$notification.response.failedAttempts:=0
			$notification.response.code:=0
			$notification.status:=0  //Pending
			$notification.creationDate:=Current date:C33(*)
			$notification.save()
			
			
		End if 
	End if 
	
Else 
	//error no "TO" address provided
End if 
