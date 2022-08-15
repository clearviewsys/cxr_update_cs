//%attributes = {}
// #ORDA

C_TEXT:C284($0)
C_OBJECT:C1216($serverPrefs)

$serverPrefs:=ds:C1482.ServerPrefs.all().first()
$0:=""

If ($serverPrefs.LDAP_RootEntry#Null:C1517)
	If ($serverPrefs.LDAP_RootEntry#"")
		$0:=$serverPrefs.LDAP_RootEntry
	End if 
End if 

