initDateRangeVars
handleListForm

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Activate:K2:9))
	
End if 

If ((Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
	calcItemsRepLineVars
	colourizeAlternateRows([Items:39]isFlagged:13)
	
End if 

