lockScreen
If (User in group:C338(Current user:C182; "Aministrators"))
	myAlert("It is not safe for the administrator to lock the screen for a long time.  ")
	switchSystemUser
End if 
