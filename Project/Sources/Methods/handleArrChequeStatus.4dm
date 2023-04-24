//%attributes = {}
C_POINTER:C301($1)
bindPopUpToIntegerField($1; ->[Cheques:1]chequeStatus:14)
If ([Cheques:1]chequeStatus:14=1)  // deposited

	If ([Cheques:1]DepositDate:17=!00-00-00!)
		[Cheques:1]DepositDate:17:=Current date:C33
	End if 
Else 
	[Cheques:1]DepositDate:17:=!00-00-00!
End if 