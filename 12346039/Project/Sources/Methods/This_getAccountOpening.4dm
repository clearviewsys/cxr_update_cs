//%attributes = {}
// This_getAccountOpening
// this method shall be called in a listbox column expression

C_REAL:C285($0)

If (numToBoolean(Form:C1466.applyDates))  // tru
	$0:=getAccountBalance(This:C1470.AccountID; !00-00-00!; Add to date:C393(vtoDate; 0; 0; -1); True:C214; Form:C1466.branchID)
Else 
	$0:=0
End if 