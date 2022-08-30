//%attributes = {}
// this method is called from the Registers table trigger (on save, on modify)


[Registers:10]UnrealizedGain:56:=CalcUnrealizedGain
[Registers:10]totalFees:30:=calcRegisterTotalFees
RELATE ONE:C42([Registers:10]AccountID:6)
[Registers:10]isTrade:38:=isThisRegisterATrade
[Registers:10]isCash:40:=[Accounts:9]isCashAccount:3

If ([Registers:10]baseCURR:60="")
	[Registers:10]baseCURR:60:=<>BASECURRENCY
End if 

If ([Registers:10]AutoComments:12=True:C214)
	[Registers:10]Comments:9:=makeCommentsForInvoiceLines
End if 
