

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Customer Transactions summarized by Customer groups")
		//fillCustGroupSummaryTableArrays 
		
	: (Form event code:C388=On Outside Call:K2:11)
		handleSR_CustomerGroups
	Else 
		
End case 
