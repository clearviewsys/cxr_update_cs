//%attributes = {}
// getWalkInCustomerID -> string

// accessor to the walk in customer ID


C_TEXT:C284($0)

If (getBranchID="")
	$0:="000"
Else 
	$0:="000-"+getBranchID
End if 