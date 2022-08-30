//%attributes = {}
//gets the value of element $1 in web area $2

C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $element)
C_TEXT:C284($0; $js; $result)

$wa:=$1
$element:=$2

$js:="document.getElementById('"+$element+"').value;"

$result:=WA Evaluate JavaScript:C1029(*; "mywa"; $js)

$0:=$result
