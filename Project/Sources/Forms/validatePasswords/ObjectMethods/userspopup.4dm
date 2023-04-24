var $selectedUser : Object
var $lastLogin : Date
var $name; $startup; $oldPassword : Text
var $nbLogin; $groupOwner; $newUserID : Integer

If (Form event code:C388=On Data Change:K2:15)
	
	If (Form:C1466.users.index#Null:C1517)
		
		$selectedUser:=Form:C1466.userlist[Form:C1466.users.index]
		
		GET USER PROPERTIES:C611($selectedUser.index; $name; $startup; $oldPassword; $nbLogin; $lastLogin; $memberships; $groupOwner)
		
	End if 
	
End if 
