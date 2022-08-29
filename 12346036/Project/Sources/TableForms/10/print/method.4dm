C_TEXT:C284(vRegisterType)
vRegisterType:=""

If (Form event code:C388=On Printing Detail:K2:18)
	RELATE ONE:C42([Registers:10]CustomerID:5)
	C_REAL:C285(vTaxes; vSumTotalFees)
	vTaxes:=[Registers:10]tax1_Paid:33+[Registers:10]tax2_Paid:34+[Registers:10]tax1_Received:31+[Registers:10]tax2_Received:32
	
	vRegisterType:=""
	If ([Registers:10]isTrade:38)
		If ([Registers:10]Debit:8>0)
			vRegisterType:="Buy"
		Else 
			vRegisterType:="Sell"
		End if 
	End if 
	If ([Registers:10]isTransfer:3)
		If ([Registers:10]Debit:8>0)
			vRegisterType:="Tr-In"
		Else 
			vRegisterType:="Tr-Out"
		End if 
	End if 
End if 


If (Form event code:C388=On Printing Break:K2:19)
	C_REAL:C285(vSumDebits; vSumCredits; vSumFees)
	C_REAL:C285(vSumtax1R; vSumtax2R; vSumtax1P; vSumtax2P)
	vSumDebits:=Subtotal:C97([Registers:10]DebitLocal:23)
	vSumCredits:=Subtotal:C97([Registers:10]CreditLocal:24)
	
	vSumtax1R:=Subtotal:C97([Registers:10]tax1_Received:31)
	vSumTax2R:=Subtotal:C97([Registers:10]tax2_Received:32)
	vTotalTaxR:=vSumTax1R+vSumTax2R
	
	vSumTax1P:=Subtotal:C97([Registers:10]tax1_Paid:33)
	vSumTax2P:=Subtotal:C97([Registers:10]tax2_Paid:34)
	vTotalTaxP:=vSumTax1P+vSumTax2P
	
	
	vSumTotalFees:=Subtotal:C97([Registers:10]totalFees:30)
End if 