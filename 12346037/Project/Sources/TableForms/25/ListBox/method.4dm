//This_GreyIf
If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305($show)
	$show:=isUserSuperAdmin
	setVisibleIff($show; "b_ResetAdminPass")
	setVisibleIff($show; "b_deleteHistoricalPasswords")
End if 

