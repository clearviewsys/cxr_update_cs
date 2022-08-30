//%attributes = {}

//Unit test completed by @Zoya

C_TEXT:C284($1; $tAddress)
C_BOOLEAN:C305($0)

C_TEXT:C284($tPattern)

$tAddress:=$1

$tPattern:="(?i)^([A-Z0-9._%+-]+)@(?:[A-Z0-9_-]+\\.)+([A-Z]{2,4})$(.*)"

If (Match regex:C1019($tPattern; $tAddress))
	$0:=True:C214
Else 
	$0:=False:C215
End if 