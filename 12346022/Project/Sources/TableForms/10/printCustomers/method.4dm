C_REAL:C285($sumDebit; $sumCredit)

If (Form event code:C388=On Header:K2:17)
	RELATE ONE:C42([Registers:10]CustomerID:5)
End if 

If (Form event code:C388=On Printing Detail:K2:18)
End if 

If (Form event code:C388=On Printing Break:K2:19)
	$sumDebit:=Subtotal:C97([Registers:10]Debit:8)
	$sumCredit:=Subtotal:C97([Registers:10]Credit:7)
End if 