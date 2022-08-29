C_TEXT:C284($comment; $phone)
$comment:=makeCommentsBooking
$phone:=myRequest("Customer Cell phone:"; [Customers:3]CellPhone:13)
If (OK=1)
	If ($phone#"")
		sendNotificationBySMS($phone; $comment; [Customers:3]CountryCode:113)
		//sendNotificationBySMS ($phone;$comment)
		//SMS_sendViaSMTP ($phone;$comment)
	Else 
		myAlert("No cell phone provided")
	End if 
End if 