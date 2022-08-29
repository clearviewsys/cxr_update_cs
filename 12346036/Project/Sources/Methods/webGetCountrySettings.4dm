//%attributes = {"publishedWeb":true,"shared":true}
C_TEXT:C284($1; $countryCode)

C_OBJECT:C1216($0; $status)

C_COLLECTION:C1488($col)


$countryCode:=$1


$col:=New collection:C1472
$col:=Storage:C1525.wiresMap.query("alpha2 == :1"; $countryCode)

$status:=New object:C1471

If ($col.length>0)
	$status.success:=True:C214
	$status.result:=$col
Else 
	$status.success:=False:C215
	$status.result:=New collection:C1472
	$status.statusText:="Country NOT found."
End if 


$0:=$status