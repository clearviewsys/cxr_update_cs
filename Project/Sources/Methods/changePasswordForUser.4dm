//%attributes = {}
#DECLARE($username : Text; $newPassword : Text)

var $userID : Integer

$userID:=findUserID($username)

If ($userID>0)
	
	changePasswordForUserID($userID; $newPassword)
	
End if 
