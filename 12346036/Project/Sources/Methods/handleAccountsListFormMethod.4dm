//%attributes = {}
// handleAccountListFormMethod

C_REAL:C285(vSumDebits; vSumCredits; vBalance; vSumDebitsLocal; vSumCreditsLocal; vBalanceLocal; vOpeningBalance)
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Activate:K2:9))
	//
	getAccountBalanceInDateRange1([Accounts:9]AccountID:1; vFromDate; vToDate; numToBoolean(cbApplyDateRange); ->vOpeningBalance; ->vSumDebits; ->vSumCredits; ->vBalance)
	
End if 

If (Form event code:C388=On Display Detail:K2:22)
	
	If (isUserAllowedToViewThisAccount)
		getAccountBalanceInDateRange1([Accounts:9]AccountID:1; vFromDate; vToDate; numToBoolean(cbApplyDateRange); ->vOpeningBalance; ->vSumDebits; ->vSumCredits; ->vBalance)
	End if 
	
	colourizeAlternateRows([Accounts:9]isFlagged:13)
	hideObjectsOnTrue(Not:C34([Accounts:9]isFlagged:13); "flag")
	hideObjectsOnTrue(Not:C34([Accounts:9]isForeignAccount:15); "AgentIcon")
	If ((([Accounts:9]isDebit:11) & (vBalance<0)) | ((Not:C34([Accounts:9]isDebit:11)) & (vBalance>0)))
		colorizeNegs(->vBalance)
	Else 
		// _O_OBJECT SET COLOR(vBalance;calcColour(Black;White))
		OBJECT SET RGB COLORS:C628(vBalance; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
	End if 
End if 
