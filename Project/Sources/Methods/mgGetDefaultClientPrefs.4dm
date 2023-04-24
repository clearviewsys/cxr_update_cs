//%attributes = {}
C_OBJECT:C1216($0; $clientMGPrefs; $clientPrefs)
C_TEXT:C284($clientName)

$clientName:=getCurrentMachineName

$clientMGPrefs:=New object:C1471
$clientMGPrefs.credentials:=New object:C1471
$clientMGPrefs.credentials.username:="clerk"
$clientMGPrefs.credentials.agentID:="30015010"
$clientMGPrefs.credentials.password:="123123"

$clientPrefs:=ds:C1482.ClientPrefs.query("ClientName = :1"; $clientName).first()

If ($clientPrefs#Null:C1517)
	$clientMGPrefs.clientName:=$clientPrefs.ClientName
Else 
	$clientMGPrefs.clientName:=$clientName
End if 

$clientMGPrefs.certificatesPath:=Get 4D folder:C485(Current resources folder:K5:16)+"MG"+Folder separator:K24:12

$0:=$clientMGPrefs
