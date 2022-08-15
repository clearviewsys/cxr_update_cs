//%attributes = {}
// performs click on element $2 in Web area $1

C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $elementID)
C_TEXT:C284($js; $result)

$wa:=$1
$elementID:=$2

$js:="document.getElementById('"+$elementID+"').click();"

$result:=WA Evaluate JavaScript:C1029(*; "mywa"; $js)
