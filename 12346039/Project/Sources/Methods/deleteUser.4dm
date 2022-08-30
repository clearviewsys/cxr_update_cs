//%attributes = {}
// deleteUser

C_TEXT:C284($user)
$user:=Request:C163("Which User to Delete")
If ($user#"")
	DELETE USER:C615(getSystemUserID($user))
End if 
