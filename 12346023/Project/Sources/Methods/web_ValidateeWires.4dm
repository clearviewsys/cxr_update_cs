//%attributes = {}
checkInit
//checkAddError ("More checks to perform on webbupdateewires")

If (isCheckBoxSwitchedOn(->[eWires:13]isCancelled:34))  // THIS IS WHEN AN EWIRE IS CANCELLED , 
	checkAddErrorIf(([eWires:13]isSettled:23=True:C214); "Cannot cancel an eWire that has been already paid off.")
	//checkAddErrorIf (([eWires]comments_Visible="");"Please enter a reason for cancelling in the public remark.")
	//checkAddErrorIf (([eWires]ForeignAccount#"Cancelled");"Please select the account as Cancelled.")
End if 

// if a sent ewire is being paid a confirmation number must be provided
If (([eWires:13]isPaymentSent:20) & ([eWires:13]isSettled:23))
	//If ([eWires]LinkMsg="")
	//checkAddError ("Please provide detail of payment in Link Message.")
	//End if 
	If ([eWires:13]ReferenceNo:28="")
		checkAddError("Please enter your confirmation number for the payment.")
	End if 
End if 

If (([eWires:13]ReferenceNo:28#"") & ([eWires:13]isSettled:23=False:C215))
	checkAddError("You cannot enter a confirmation without paying the eWire.")
End if 

// check to see if it's locked
If (Locked:C147([eWires:13]))
	checkAddError("This record is being edited by another user at this time. Please review it later."+" Thanks.")
End if 

