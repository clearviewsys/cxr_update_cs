//%attributes = {}
// createEmailNotification (to, subject, message, {attachments:collection} , from , CC, BCC)

C_TEXT:C284($1; $to)  //to
C_TEXT:C284($2; $subject)  //subject
C_TEXT:C284($3; $message)  //message
C_COLLECTION:C1488($4; $attachments)  //attachment paths inside the collection
C_TEXT:C284($5; $from)
C_TEXT:C284($7; $cc)
C_TEXT:C284($8; $bcc)


Case of 
	: (Count parameters:C259=3)  //minimum needed
		$to:=$1
		$subject:=$2
		$message:=$3
		$attachments:=Null:C1517
		$from:=<>smtpFromEmail
		$cc:=""
		$bcc:=""
		
	: (Count parameters:C259=4)
		$to:=$1
		$subject:=$2
		$message:=$3
		$attachments:=$4
		$from:=<>smtpFromEmail
		$cc:=""
		$bcc:=""
		
	: (Count parameters:C259=5)
		$to:=$1
		$subject:=$2
		$message:=$3
		$attachments:=$4
		$from:=$5
		$cc:=""
		$bcc:=""
		
	: (Count parameters:C259=6)
		$to:=$1
		$subject:=$2
		$message:=$3
		$attachments:=$4
		$from:=$5
		$cc:=$6
		$bcc:=""
		
	: (Count parameters:C259=7)
		$to:=$1
		$subject:=$2
		$message:=$3
		$attachments:=$4
		$from:=$5
		$cc:=$6
		$bcc:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($from="")
	$from:=""  //system from
End if 


$to:=strRemoveSpaces($to)

C_OBJECT:C1216($o; $status)

$o:=New object:C1471

$o.messageType:="email"
$o.createByUser:=getSystemUserName
$o.creationDate:=Current date:C33(*)
$o.creationTime:=Current time:C178(*)

$o.to:=$to
$o.from:=$from
$o.cc:=$cc
$o.bcc:=$bcc
$o.replyTo:=$from

$o.subject:=$subject
$o.message:=$message

If ($attachments=Null:C1517)
Else 
	If (Application type:C494=4D Remote mode:K5:5)
		// need to send attachments too server so notification process has access
		C_COLLECTION:C1488($col)
		C_TEXT:C284($attachment)
		$col:=New collection:C1472  // collectiono of server paths for the attachments
		
		For each ($attachment; $attachments)
			$col.push(DOC_storeDocumentPath($attachment))
		End for each 
		
		$o.attachments:=$col
	Else 
		$o.attachments:=$attachments
	End if 
End if 

If ($o.to="")  //don't create if there is no email address
Else 
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
		$status:=$notification.save()
	End if 
End if 

