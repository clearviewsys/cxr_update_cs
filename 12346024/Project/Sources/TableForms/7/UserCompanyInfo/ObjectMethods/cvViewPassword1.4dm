If (isUserAdministrator)
	If (Self:C308->=0)
		OBJECT SET FONT:C164(*; "clientKey"; "%Password")
	Else 
		OBJECT SET FONT:C164(*; "clientKey"; "Arial")
	End if 
End if 
