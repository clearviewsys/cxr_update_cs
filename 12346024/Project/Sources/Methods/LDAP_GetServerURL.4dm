//%attributes = {}
// #ORDA
C_OBJECT:C1216($serverPrefs)
C_TEXT:C284($0; $prefix; $port; $url)

$0:=""
$prefix:="ldap://"
$port:="389"
$url:=""

$serverPrefs:=ds:C1482.ServerPrefs.all().first()

If ($serverPrefs.LDAP_ServerAddress#Null:C1517)
	If ($serverPrefs.LDAP_ServerAddress#"")
		$url:=$serverPrefs.LDAP_ServerAddress
	End if 
End if 

If ($serverPrefs.LDAP_USESECURE#Null:C1517)
	If ($serverPrefs.LDAP_USESECURE=True:C214)
		$prefix:="ldaps://"
	End if 
End if 

If ($serverPrefs.LDAP_PORT#Null:C1517)
	If ($serverPrefs.LDAP_PORT#"")
		$port:=$serverPrefs.LDAP_PORT
	End if 
End if 

If (($prefix#"") & ($port#"") & ($url#""))
	$0:=$prefix+$url+":"+$port
End if 
