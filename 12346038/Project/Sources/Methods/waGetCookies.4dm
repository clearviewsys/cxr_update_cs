//%attributes = {}
// gets cookies from currently displayed page in WebArea
// Returns string like this one:
// cookie_name1=cookie_value1; cookie_name2=cookie_value2

C_TEXT:C284($0; $js)
C_TEXT:C284($1; $wa)  // Web area form object name

$wa:=$1

$js:="document.cookie"

$0:=WA Evaluate JavaScript:C1029(*; $wa; $js)
