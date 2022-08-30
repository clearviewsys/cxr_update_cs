If (vUserName="Designer") | (vUserName="Administrator") | (vUserName="Support")
	myAlert("This function cannot be used for system accounts")
Else 
	If (vUserName#"")
		forgotPassword(vUserName)
	End if 
End if 
