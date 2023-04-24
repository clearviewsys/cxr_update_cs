//%attributes = {}
// #ORDA
C_OBJECT:C1216($serverPrefs)
C_BOOLEAN:C305($0)

$0:=False:C215

If (False:C215)
	
	$serverPrefs:=ds:C1482.ServerPrefs.all().first()
	
	If ($serverPrefs.useSSO#Null:C1517)
		If ($serverPrefs.useSSO=True:C214)
			$0:=True:C214
		End if 
	End if 
	
Else 
	
	ALL RECORDS:C47([ServerPrefs:27])
	
	If ([ServerPrefs:27]useSSO:119)
		$0:=True:C214
	End if 
	
End if 
