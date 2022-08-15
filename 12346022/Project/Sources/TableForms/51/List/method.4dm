handleListForm
If (Form event code:C388=On Display Detail:K2:22)
	colourizeAlternateRows([CallLogs:51]isFlagged:7)
	showObjectOnTrue([CallLogs:51]doPopUp:8; "blueDot")
	RELATE ONE:C42([CallLogs:51]CustomerID:2)
End if 
