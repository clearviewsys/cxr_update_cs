//%attributes = {}
// getNotificationsTypeName (value:longint) : text
// returns the Notication Type of given ID number $1

C_LONGINT:C283($1; $tNotificationTypeID)
$tNotificationTypeID:=$1
C_TEXT:C284($0; $tNotificationTypeName)
Case of 
	: ($tNotificationTypeID=1)
		$tNotificationTypeName:="✉ email"
		
	: ($tNotificationTypeID=2)
		$tNotificationTypeName:="☎ sms"
End case 
$0:=$tNotificationTypeName