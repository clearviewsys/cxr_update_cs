//%attributes = {}
C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $element)
C_TEXT:C284($js; $result)

$wa:=$1
$element:=$2

$js:="var element = document.getElementById('"+$element+"');\r"
$js:=$js+"var event=new Event('change');\r"
$js:=$js+"element.dispatchEvent(event);\r"

$result:=WA Evaluate JavaScript:C1029(*; $wa; $js)
