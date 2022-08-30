//%attributes = {}
//Method twilioLogMessage
//Purpose: Create a log record for a twilio message
//Parameters: (string)message (string)toNumber (string)fromNumber (string)response (string)status
//#ORDA

C_DATE:C307($date)
C_TIME:C306($time)
C_OBJECT:C1216($newRecord)
C_TEXT:C284($message; $toNumber; $fromNumber; $response; $status; $1; $2; $3; $4; $5)

$date:=Current date:C33
$time:=Current time:C178

Case of 
	: (Count parameters:C259=5)
		$message:=$1
		$toNumber:=$2
		$fromNumber:=$3
		$response:=$4
		$status:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$newRecord:=ds:C1482.Twilio_Log.new()
$newRecord.date:=$date
$newRecord.time:=$time
$newRecord.message:=$message
$newRecord.toNumber:=$toNumber
$newRecord.fromNumber:=$fromNumber
$newRecord.response:=$response
$newRecord.status:=$status

$newRecord.save()