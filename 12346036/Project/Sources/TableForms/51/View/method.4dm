handleViewForm

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
	RELATE ONE:C42([CallLogs:51]CustomerID:2)
End if 