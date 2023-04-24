//%attributes = {}
C_POINTER:C301($tablePtr; $tablePtr2)

$tablePtr:=->[Registers:10]
$tablePtr2:=->[RegistersAuditTrail:88]

C_TEXT:C284($code; $line1; $line2)
C_LONGINT:C283($i; $n)
$n:=Get last field number:C255($tablePtr)

For ($i; 1; $n)
	
	If (Is field number valid:C1000($tablePtr; $i))
		$line1:="["+Table name:C256($tablePtr)+"]"+Field name:C257(Table:C252($tablePtr); $i)
		$line2:="["+Table name:C256($tablePtr2)+"]"+"orig_"+Field name:C257(Table:C252($tablePtr); $i)
		$code:=$code+$line2+":="+$line1+CRLF
	End if 
	
End for 

SET TEXT TO PASTEBOARD:C523($code)
