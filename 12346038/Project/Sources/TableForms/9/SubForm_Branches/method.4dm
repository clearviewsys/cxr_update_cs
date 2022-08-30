C_REAL:C285(vBalance; vWithdrawals; vDeposits; vDebitsLocal; vCreditsLocal; vBalanceLocal)
If (Form event code:C388=On Display Detail:K2:22)
	vDeposits:=0
	vWithdrawals:=0
	vDebitsLocal:=0
	vCreditsLocal:=0
	
	QUERY:C277([Registers:10]; [Registers:10]AccountID:6=[Accounts:9]AccountID:1)
	If (([Accounts:9]AccountID:1#"") & (Records in selection:C76([Registers:10])>0))
		vDeposits:=Sum:C1([Registers:10]Debit:8)
		vWithdrawals:=Sum:C1([Registers:10]Credit:7)
		vDebitsLocal:=Sum:C1([Registers:10]DebitLocal:23)
		vCreditsLocal:=Sum:C1([Registers:10]CreditLocal:24)
		//colorizeNegs (->vBalance)
	End if 
	vBalance:=vDeposits-vWithdrawals
	vBalanceLocal:=vDebitsLocal-vCreditsLocal
	colourizeLineBG("backstripe")
End if 

