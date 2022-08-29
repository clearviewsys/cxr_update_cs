If (Form event code:C388=On Load:K2:1)
	//handleFillCurrencySummaryTable 
	OBJECT SET TITLE:C194(*; "ReportTitle"; "Currency Purchases and Sales In Period")
	
End if 

If (Form event code:C388=On Outside Call:K2:11)
	handleSR_Currencies
End if 

