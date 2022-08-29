//%attributes = {}

// createSMSNotification

C_TEXT:C284($1; $toNumber)
C_TEXT:C284($2; $message)
C_TEXT:C284($3; $fromNumber)

Case of 
	: (Count parameters:C259=2)
		$toNumber:=$1
		$message:=$2
		// what happens to $fromNumbeR?  // @tiran if the fromNumber is not sent? what's the default value? 
		
	: (Count parameters:C259=3)
		$toNumber:=$1
		$message:=$2
		$fromNumber:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_OBJECT:C1216($notification)

$notification:=ds:C1482.Notifications.new()
//$notification.ID:=makeNotificationsID 
$notification.UUID:=Generate UUID:C1066
$notification.type:=2  //SMS
$notification.status:=0  //Pending
$notification.creationDate:=Current date:C33(*)

C_OBJECT:C1216($messagedetails)
$messagedetails:=New object:C1471
$messagedetails.message:=$message
$messagedetails.to:=$toNumber
$messagedetails.from:=$fromNumber
$messagedetails.messageType:="sms"
$messagedetails.createByUser:=getSystemUserName
$messagedetails.creationDate:=Current date:C33(*)
$messagedetails.creationTime:=Current time:C178(*)
$messagedetails.subject:=$message
$notification.message:=$messagedetails

C_OBJECT:C1216($response)
$response:=New object:C1471
OBJ_newResponse(->$response)
$notification.response:=$response
$notification.response.failedAttempts:=0
$notification.response.code:=0

$notification.save()
