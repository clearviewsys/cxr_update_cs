//%attributes = {}
// getNotificationsTypeEmoji (value:longint) : text
// returns the Notication Type of given ID number $1

C_LONGINT:C283($1; $tNotificationTypeID)
C_TEXT:C284($0; $tNotificationTypeName)

$tNotificationTypeID:=$1

Case of 
	: ($tNotificationTypeID=1)
		$tNotificationTypeName:="✉"
		
	: ($tNotificationTypeID=2)
		$tNotificationTypeName:="☎"
		
End case 
$0:=$tNotificationTypeName