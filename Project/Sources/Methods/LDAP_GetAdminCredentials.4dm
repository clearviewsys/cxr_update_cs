//%attributes = {}
// #ORDA

C_OBJECT:C1216($0; $credentials; $serverPrefs)
C_TEXT:C284($admin; $adminPassword)

$serverPrefs:=ds:C1482.ServerPrefs.all().first()


If ($serverPrefs.LDAP_Admin#Null:C1517)
	If ($serverPrefs.LDAP_Admin#"")
		$admin:=$serverPrefs.LDAP_Admin
	End if 
End if 

If ($serverPrefs.LDAP_AdminPassword#Null:C1517)
	If ($serverPrefs.LDAP_AdminPassword#"")
		$adminPassword:=$serverPrefs.LDAP_AdminPassword
	End if 
End if 

If (($admin#"") & ($adminPassword#""))
	$credentials:=New object:C1471
	$credentials.userName:=$admin
	$credentials.password:=$adminPassword
End if 

// for development only

//If (True)
//$credentials:=New object
//$credentials.userName:="tiran"
//$credentials.password:="Milan1234"
//End if 

$0:=$credentials

