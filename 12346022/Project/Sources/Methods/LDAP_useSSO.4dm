//%attributes = {}
// #ORDA
C_OBJECT:C1216($serverPrefs)
C_BOOLEAN:C305($0)

$serverPrefs:=ds:C1482.ServerPrefs.all().first()
$0:=False:C215

If ($serverPrefs.useSSO#Null:C1517)
	If ($serverPrefs.useSSO=True:C214)
		$0:=True:C214
	End if 
End if 
