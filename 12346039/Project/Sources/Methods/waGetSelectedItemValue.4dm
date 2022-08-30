//%attributes = {}
// returns value of selected item from ddrop down menu
C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $dropDown)
C_TEXT:C284($0)
C_TEXT:C284($js; $result)

$wa:=$1
$dropDown:=$2

// var yourSelect=document.getElementById("your-select-id");
// alert( yourSelect.options[ yourSelect.selectedIndex ].value )

$js:="var dd=document.getElementById('"+$dropDown+"');\r\r"
$js:=$js+"dd.options[dd.selectedIndex].value;\r\r"

$result:=WA Evaluate JavaScript:C1029(*; $wa; $js)

$0:=$result
