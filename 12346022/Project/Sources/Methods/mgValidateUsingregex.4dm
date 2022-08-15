//%attributes = {}
C_TEXT:C284($pattern; $1)
C_TEXT:C284($2; $teststring)
C_LONGINT:C283($len; $pos_found; $fromPos; $testLen; $totalLen)
C_BOOLEAN:C305($0; $match)

$pattern:=$1
$teststring:=$2

ARRAY TEXT:C222($foundGroups; 0)

$fromPos:=1
$testLen:=Length:C16($teststring)
$totalLen:=0

Repeat 
	
	$match:=Match regex:C1019($pattern; $teststring; $fromPos; $pos_found; $len)
	
	APPEND TO ARRAY:C911($foundGroups; Substring:C12($teststring; $fromPos; $len))
	
	$totalLen:=$totalLen+Length:C16($foundGroups{Size of array:C274($foundGroups)})
	
	$fromPos:=$fromPos+$len+1
	
Until (Not:C34($match) | ($fromPos>$testLen))

If ($totalLen#$testLen)
	$0:=False:C215
Else 
	$0:=True:C214
End if 
