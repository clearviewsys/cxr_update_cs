var $selectedUser : Object
var $ok : Boolean

If (Form:C1466.users.index#Null:C1517)
	
	$selectedUser:=Form:C1466.userlist[Form:C1466.users.index]
	
	If (Form:C1466.password#"")
		
		$ok:=Validate password:C638($selectedUser.index; Form:C1466.password)
		
		If ($ok)
			ALERT:C41("passwords match")
		Else 
			ALERT:C41("WRONG!!!!!")
		End if 
		
	End if 
	
End if 

