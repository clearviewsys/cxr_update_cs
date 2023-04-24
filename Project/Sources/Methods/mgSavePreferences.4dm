//%attributes = {"executedOnServer":true}
C_OBJECT:C1216($1; $clientPrefs)
C_COLLECTION:C1488($allServerPrefs; $find)
C_BOOLEAN:C305($0)

$clientPrefs:=$1
$allServerPrefs:=mgLoadPrefsOnServer
$0:=False:C215

If ($allServerPrefs=Null:C1517)
	$allServerPrefs:=New collection:C1472
End if 

If ($allServerPrefs#Null:C1517)
	
	$find:=$allServerPrefs.indices("clientName = :1"; $clientPrefs.clientName)
	
	If ($find#Null:C1517)
		
		If ($find.length>0)
			$allServerPrefs[$find[0]]:=$clientPrefs
		Else 
			$allServerPrefs.push($clientPrefs)
		End if 
		
	Else 
		
		$allServerPrefs.push($clientPrefs)
		
	End if 
	
	$0:=mgSavePrefsOnServer($allServerPrefs)
	
End if 

