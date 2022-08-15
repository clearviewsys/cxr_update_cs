handleViewForm
C_TEXT:C284(vCurrencyQuery)

If (Form event code:C388=On Load:K2:1)
	vCurrencyQuery:=""
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	//handleCurrencyQueryInMainAccoun
	handleMainAccountsViewListBox  // Added in Feb 2008,ver 3.13 TB
End if 

calcAccountsListBoxSumVars
//calcSumVarsInMainAccountsView 

