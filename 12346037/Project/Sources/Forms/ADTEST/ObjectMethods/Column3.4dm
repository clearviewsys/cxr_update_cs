C_TEXT:C284($username)
C_BOOLEAN:C305($allowLDAP)

If (Form event code:C388=On Data Change:K2:15)
	
	$username:=Form:C1466.selectedMember.sAMAccountName
	$allowLDAP:=Form:C1466.selectedMember.allowLDAP
	
	C_OBJECT:C1216($localuser)
	
	$localuser:=ds:C1482.Users.query("UserName = :1"; $username).first()
	
	If ($localuser=Null:C1517)
		$localuser:=ds:C1482.Users.new()
		$localuser.UserName:=$username
	End if 
	
	$localuser.isAllowedLDAPLogin:=$allowLDAP
	$localuser.save()
	
End if 
