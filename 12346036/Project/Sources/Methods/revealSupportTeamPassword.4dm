//%attributes = {}
C_TEXT:C284($startup; password; $name)
C_DATE:C307($LASTLOGIN)
C_LONGINT:C283($nbLogin; $vlElem)

GET USER LIST:C609(atUserName; alUserID)
$vlElem:=Find in array:C230(atUserName; "Support Team")
If ($vlElem>0)
	GET USER PROPERTIES:C611(alUserID{$vlElem}; $name; $startup; password; $nbLogin; $lastLogin)
	myAlert("Password : "+password)
Else 
	myAlert("Support Teach is deleted from users lists.")
End if 
