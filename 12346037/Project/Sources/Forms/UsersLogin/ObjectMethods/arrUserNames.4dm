
If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	//vUserName:=arrUserNames{arrUserNames} old way
	vUserName:=Self:C308->{Self:C308->}
	
	If (False:C215)
		//user_handleUserNameMethod
		//setVisibleIff(vUserName#""; "changePassword")
		//setVisibleIff(vUserName#""; "loginButton")
		//setVisibleIff(vUserName#""; "forgotPassword")
	Else 
		
		user_LDAPhandleUserNameMethod
		
		C_BOOLEAN:C305($useSSO; $useLDAP; $complex)
		
		
		$useSSO:=LDAP_useSSO
		$useLDAP:=LDAP_useLDAP
		
		$complex:=(vUserName#"")
		$complex:=$complex & (Not:C34($useLDAP))
		$complex:=$complex & (Not:C34($useSSO))
		
		
		setVisibleIff($complex; "changePassword")
		setVisibleIff(vUserName#""; "loginButton")
		setVisibleIff($complex; "forgotPassword")
		
	End if 
	
End if 
