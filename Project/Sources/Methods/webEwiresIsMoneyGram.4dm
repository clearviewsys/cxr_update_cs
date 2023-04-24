//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($1; $webewireID)

$webewireID:=$1

If ($webewireID="@MG@")
	$0:=True:C214
Else 
	$0:=False:C215
End if 
