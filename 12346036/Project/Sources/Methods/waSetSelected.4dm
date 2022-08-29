//%attributes = {}
//var valueTofind='Google';

//var dd=document.getElementById('MyDropDown');
//For (var i=0;i<dd.options.length;i++){
//If (dd.options[i].text===valueTofind){
//dd.selectedIndex=i;
//break;
//}
//}

C_TEXT:C284($1; $wa)
C_TEXT:C284($2; $dropDown)
C_TEXT:C284($3; $setMe)
C_TEXT:C284($js; $result)


$wa:=$1
$dropDown:=$2
$setMe:=$3

$js:="var valueTofind='"+$setMe+"';\r"
$js:=$js+"var dd=document.getElementById('"+$dropDown+"');\r\r"
$js:=$js+"For (var i=0;i<dd.options.length;i++){\r\tIf (dd.options[i].value===valueTofind){\r\t\tdd.selectedIndex=i;\r\t\tbreak;}}\r"


// let element=document.getElementById(id);
// element.value=valueToSelect;

$js:="var dd=document.getElementById('"+$dropDown+"');\r\r"
$js:=$js+"dd.value='"+$setMe+"';"

$result:=WA Evaluate JavaScript:C1029(*; $wa; $js)

