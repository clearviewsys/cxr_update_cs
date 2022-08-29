

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Customer's Summary of Transactions")
		//fillCustomerSummaryTableArrays 
		
	: (Form event code:C388=On Outside Call:K2:11)
		handleSR_CustomerTrans
	Else 
		
End case 
