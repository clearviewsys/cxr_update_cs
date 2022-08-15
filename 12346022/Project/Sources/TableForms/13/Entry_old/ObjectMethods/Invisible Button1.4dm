CONFIRM:C162("Are you sure you want to switch the status of the payment")
If (OK=1)
	[eWires:13]isSettled:23:=Not:C34([eWires:13]isSettled:23)
	
End if 