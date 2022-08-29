//%attributes = {}
C_TEXT:C284($1; $url)

C_TEXT:C284($0; $context)

C_LONGINT:C283($iPos)


$url:=$1
$context:=""


If (Position:C15("/"; $URL)=1)
	$URL:=Substring:C12($URL; 2; Length:C16($URL))  //strip leading /
End if 

$iPos:=Position:C15("/"; $url)

If ($iPos>0)
	$context:=Substring:C12($url; 1; $iPos-1)
End if 


$0:=$context