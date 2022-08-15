//%attributes = {}
C_TEXT:C284($1; $countryCode)
C_TEXT:C284($site)


$countryCode:=$1

If ($countryCode="")
Else 
	$site:=getKeyValue("sync.siteid.countrycode."+$countryCode)
End if 

If (Length:C16($site)=4)  //site IDs are 4 digits
	Sync_primaryKeyID($site)
Else 
	Sync_primaryKeyID("")  //clear
End if 