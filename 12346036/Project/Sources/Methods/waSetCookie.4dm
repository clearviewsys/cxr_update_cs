//%attributes = {}
// sets one cookie in WebArea

C_TEXT:C284($1; $webArea)
C_TEXT:C284($2; $cookie)
C_TEXT:C284($3; $value)
C_LONGINT:C283($4; $daysToExpire)
C_TEXT:C284($result; $js; $expTxt)
C_DATE:C307($expire)

$webArea:=$1
$cookie:=$2
$value:=$3

If (Count parameters:C259>3)
	$daysToExpire:=$4
Else 
	$daysToExpire:=10
End if 

$expire:=Current date:C33+$daysToExpire
$expTxt:=String:C10($expire; Date RFC 1123:K1:11)

$js:="document.cookie="+Char:C90(Double quote:K15:41)+$cookie+"="+$value+";"+$expTxt+";path=/"+Char:C90(Double quote:K15:41)

$result:=WA Evaluate JavaScript:C1029(*; $webArea; $js)

// WA GET LAST URL ERROR(*;$webArea;$url;$descr;$errCode)

