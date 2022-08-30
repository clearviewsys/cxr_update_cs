//%attributes = {}
// ----------------------------------------------------
// Method: webPendingBookingsNotification
// Description
// trigger by Calendar Events to check every 30 minutes if there are pending bookings
// and send an email notification reminder
// ----------------------------------------------------

C_LONGINT:C283($iNotificationTimer; $iCounter)

QUERY:C277([WebEWires:149]; [WebEWires:149]status:16=0; *)  // 0=draft
QUERY:C277([WebEWires:149];  | ; [WebEWires:149]status:16=10)  //10=Pending Review - by Teller

$iNotificationTimer:=Num:C11(getKeyValue("web.configuration.notification.alert.timer"))

If ($iNotificationTimer>0)
	For ($iCounter; 1; Records in selection:C76([WebEWires:149]))
		If ((Current date:C33-[WebEWires:149]creationDate:15)>$iNotificationTimer)  // resend the webEwire internally
			webSendRecordChangeEmail(->[WebEWires:149]; "notificationReminder")
		End if 
		NEXT RECORD:C51([WebEWires:149])
	End for 
End if 