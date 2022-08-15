//%attributes = {}
C_TEXT:C284($1; $link)
C_TEXT:C284($0; $token)

C_COLLECTION:C1488($col)
C_LONGINT:C283($iPos)
C_TEXT:C284($result)
C_BOOLEAN:C305($ok)


$link:=$1

$col:=New collection:C1472
$col:=Split string:C1554($link; "/"; sk trim spaces:K86:2)

$token:=$col[$col.length-1]

$iPos:=Position:C15("?Token="; $token)
If ($iPos>0)
	$token:=Substring:C12($token; $iPos+7; Length:C16($token))
End if 


$ok:=PHP Execute:C1058(""; "rawurldecode"; $result; $token)  ///Replace string($token;"?Token=";"")

$0:=$result