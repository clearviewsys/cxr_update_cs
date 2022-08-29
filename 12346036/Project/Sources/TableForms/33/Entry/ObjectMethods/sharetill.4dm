If ([CashRegisters:33]isShared:8)  // true
	If ([CashRegisters:33]UserID:2="")
		[CashRegisters:33]UserID:2:="Shared By All Users"
	Else 
		ALERT:C41("Cannot share a till that has a signed-in user. You shall sign the user out first.")
		[CashRegisters:33]isShared:8:=False:C215
	End if 
	
Else 
	[CashRegisters:33]UserID:2:=""
End if 