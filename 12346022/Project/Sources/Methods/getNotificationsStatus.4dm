//%attributes = {}
// getNotificationsStatus (value:longint) : text
// returns the Notication Status of given ID number $1

C_LONGINT:C283($1; $tNotificationStatusNumber)
$tNotificationStatusNumber:=$1
C_TEXT:C284($0; $tNotificationStatus)
Case of 
	: ($tNotificationStatusNumber=0)
		$tNotificationStatus:="Pending"
	: ($tNotificationStatusNumber=-1)
		$tNotificationStatus:="Failed"
	: ($tNotificationStatusNumber=1)
		$tNotificationStatus:="Success"
End case 
$0:=$tNotificationStatus