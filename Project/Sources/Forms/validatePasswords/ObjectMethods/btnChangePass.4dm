var $selectedUser : Object
var $ok : Boolean
var $lastLogin : Date
var $name; $startup; $oldPassword : Text
var $nbLogin; $groupOwner; $newUserID : Integer


If (Form:C1466.users.index#Null:C1517)
	
	$selectedUser:=Form:C1466.userlist[Form:C1466.users.index]
	
	// GET USER PROPERTIES($selectedUser.index; $name; $startup; $oldPassword; $nbLogin; $lastLogin; $memberships; $groupOwner)
	
	// $newUserID:=Set user properties($selectedUser.index; $name; $startup; Form.passwordNew; $nbLogin; $lastLogin; $memberships; $groupOwner)
	
	$newUserID:=changePasswordForUserID($selectedUser.index; Form:C1466.passwordNew)
	
End if 

