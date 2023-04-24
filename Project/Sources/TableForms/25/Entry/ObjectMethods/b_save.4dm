// validateUsers
C_BOOLEAN:C305($passwordChanged)

If (Old:C35([Users:25]Password:4)#[Users:25]Password:4)
	[Users:25]forceResetDate:41:=Add to date:C393(Current date:C33; 0; <>PASSWORDRESETINTERVAL; 0)
	$passwordChanged:=True:C214
End if 

handleSaveButton

//If ($passwordChanged)
//addUsedPassword ([Users]Password)
//End if 

