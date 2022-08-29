//%attributes = {"publishedWeb":true}
C_TEXT:C284(webOldPassword; webNewPassword1; webNewPassword2; webLoginID)

checkInit

QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=webLoginID)

checkAddErrorIf(([WebUsers:14]Password:2#webOldPassword); "The old password is not correct")

checkAddErrorIf((webNewPassword1#webNewPassword2); "The New Password doesn't match with the confirmation password.")
checkAddErrorIf((Length:C16(webNewPassword1)<7); "Length of password must be more than 6 characters.")

If (checkErrorExist)
	web_SendERRORPage
Else 
	If ([WebUsers:14]relatedTable:8>0)
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=webLoginID)
		READ WRITE:C146([Customers:3])
		LOAD RECORD:C52([Customers:3])
		//[Customers]password:=webNewPassword1
		SAVE RECORD:C53([Customers:3])
		createWebUserFromCustomer_NU
		UNLOAD RECORD:C212([Customers:3])
		READ ONLY:C145([Customers:3])
	Else 
		READ WRITE:C146([Agents:22])
		LOAD RECORD:C52([Agents:22])
		[Agents:22]Password:2:=webNewPassword1
		SAVE RECORD:C53([Agents:22])
		createWebUserFromAgent
		UNLOAD RECORD:C212([Agents:22])
		READ ONLY:C145([Agents:22])
	End if 
	WEB SEND FILE:C619("passwordChanged.html")
End if 
