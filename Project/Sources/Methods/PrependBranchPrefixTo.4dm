//%attributes = {}
//prependbranchprefixTo(->fieldToPrepend; { ->fieldToassign})
// prepend the  branchID to the  uniqueID a

C_POINTER:C301($1; $2)
C_TEXT:C284($branchID)
$branchID:=getBranchID

$1->:=$branchID+($1->)

If (Count parameters:C259=2)
	$2->:=$branchID
End if 
