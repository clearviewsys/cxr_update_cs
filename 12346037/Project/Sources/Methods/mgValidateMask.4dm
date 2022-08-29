//%attributes = {}
C_BOOLEAN:C305($0)
C_TEXT:C284($validateMe; $1)
C_TEXT:C284($2; $mask)

$validateMe:=$1
$mask:=$2

$0:=True:C214

If ($mask="")
	$0:=True:C214
End if 

