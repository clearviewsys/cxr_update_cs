//%attributes = {}
// sumSelectionHomogeneous (->table;->checkField;->commonValue;->fieldToSum) -> sum
// works like sum if the selection is compatible to sum. (eg: adding the same unit)
// the return value will be 0 if there are no commonality in the checkfield
// otherwise it's going to add them up

C_POINTER:C301($1; $2; $3; $4)
C_REAL:C285($0; $sum)

If (isSelectionHomogeneous($1; $2; $3))
	$0:=Sum:C1($4->)
Else 
	$0:=0
End if 
