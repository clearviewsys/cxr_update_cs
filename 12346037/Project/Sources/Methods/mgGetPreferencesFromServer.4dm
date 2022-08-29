//%attributes = {"executedOnServer":true}
C_TEXT:C284($1; $clientName)
C_COLLECTION:C1488($all; $find)
C_OBJECT:C1216($0; $myPrefs)

$clientName:=$1

$all:=mgLoadPrefsOnServer

If ($all#Null:C1517)
	
	$find:=$all.query("clientName = :1"; $clientName)
	
	If ($find#Null:C1517)
		If ($find.length>0)
			$0:=$find[0]
		End if 
	End if 
	
End if 
