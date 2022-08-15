//%attributes = {}
C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $elementID)
C_TEXT:C284($3; $textToSet)
C_TEXT:C284($js; $result)

$wa:=$1
$elementID:=$2
$textToSet:=$3

$js:="document.getElementById("+Char:C90(Double quote:K15:41)+$elementID+Char:C90(Double quote:K15:41)+").innerText="+$textToSet

$result:=WA Evaluate JavaScript:C1029(*; $wa; $js)
