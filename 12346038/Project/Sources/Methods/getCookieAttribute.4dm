//%attributes = {}
// returns one cookie attribute from header values array received after call to HTTP Request command

C_OBJECT:C1216($0)
C_TEXT:C284($1; $currentAttribute; $atrName; $atrValue)
C_LONGINT:C283($j)
C_BOOLEAN:C305($keepGoing)

$currentAttribute:=$1

$j:=1
$keepGoing:=True:C214
$atrName:=""
$atrValue:=""

While (($j<=Length:C16($currentAttribute)) & $keepGoing)
	If ($currentAttribute[[$j]]#" ")
		$keepGoing:=($currentAttribute[[$j]]#"=")
		If ($keepGoing)
			$atrName:=$atrName+$currentAttribute[[$j]]
		End if 
	End if 
	$j:=$j+1
End while 

$keepGoing:=True:C214

While ($j<=Length:C16($currentAttribute))
	If ($currentAttribute[[$j]]#" ")
		$atrValue:=$atrValue+$currentAttribute[[$j]]
	End if 
	$j:=$j+1
End while 

If ($atrName#"")
	$0:=New object:C1471("name"; $atrName; "value"; $atrValue)
End if 
