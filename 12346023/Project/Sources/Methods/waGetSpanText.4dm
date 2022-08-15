//%attributes = {"shared":true}
C_TEXT:C284($0)
C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $spanid)
C_TEXT:C284($js)

$wa:=$1
$spanid:=$2

$js:="document.getElementById('"+$spanid+"').innerText;"

$0:=WA Evaluate JavaScript:C1029(*; "mywa"; $js)
