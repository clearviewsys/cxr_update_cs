//%attributes = {}

C_REAL:C285(vBankBalance)
C_REAL:C285(vBankBalanceAfter)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
		// after the combo box has been selected, assign the field to the new value    

		[Registers:10]AccountID:6:=vOurBankAccountID{0}
	: (Form event code:C388=On Losing Focus:K2:8)
		[Registers:10]AccountID:6:=vOurBankAccountID{0}
End case 

RELATE ONE:C42([Registers:10]AccountID:6)
RELATE ONE:C42([Accounts:9]MainAccountID:2)
RELATE ONE:C42([Wires:8]CXR_AccountID:11)
If ((Records in selection:C76([Accounts:9])=0) & (Form event code:C388=On Losing Focus:K2:8))
	BEEP:C151
	vBankBalance:=0
	vBankBalanceAfter:=0
Else 
	vOurBankAccountID{0}:=[Registers:10]AccountID:6
	PUSH RECORD:C176([Registers:10])
	vBankBalance:=getBankAccountBalance([Registers:10]AccountID:6)
	POP RECORD:C177([Registers:10])
	colorizeNegs(->vBankBalance)
	vBankBalanceAfter:=vBankBalance+[Registers:10]Debit:8-Old:C35([Registers:10]Debit:8)
	vBankBalanceAfter:=vBankBalanceAfter-[Registers:10]Credit:7+Old:C35([Registers:10]Credit:7)
	colorizeNegs(->vBankBalanceAfter)
End if 


