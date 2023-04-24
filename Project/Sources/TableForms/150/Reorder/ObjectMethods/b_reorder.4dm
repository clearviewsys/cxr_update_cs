// #ORDA

C_LONGINT:C283($i; $n)
$n:=Size of array:C274(arrRuleNo)
C_OBJECT:C1216($e; $status)
For ($i; 1; $n)
	$e:=ds:C1482.AML_AggrRules.query("UUID = :1"; arrUUID{$i})[0]  // first entity 
	$e.rowNo:=$i
	$e.thenStop:=arrStop{$i}
	$e.isActive:=arrIsActive{$i}
	$status:=$e.save()
	
End for 