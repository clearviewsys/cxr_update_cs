handleListForm
initDateRangeVars
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Activate:K2:9))
	calculateMainAccountsListVars
End if 

If (Form event code:C388=On Display Detail:K2:22)
	calcMainAccountsLineVars
	colourizeAlternateRows([MainAccounts:28]isFlagged:2)
	
End if 
