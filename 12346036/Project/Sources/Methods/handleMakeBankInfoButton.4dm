//%attributes = {}
If ([Links:17]BankingDetails:9#"")
	CONFIRM:C162("Current Bank Info will be replaced"; "Replace"; "Add to end")
	If (OK=1)
		[Links:17]BankingDetails:9:=""
	End if 
End if 

appendLabelString(->[Links:17]BankingDetails:9; "Bank: "; [Links:17]BankName:28)
appendLabelString(->[Links:17]BankingDetails:9; newLine+"Branch/Code: "; [Links:17]BankTransitCode:29)
appendLabelString(->[Links:17]BankingDetails:9; newLine+"Address: "; [Links:17]BankAddress:30)
appendLabelString(->[Links:17]BankingDetails:9; newLine+"Account No: "; [Links:17]BankAccountNo:31)
