//%attributes = {}
// CAB_HandleReportTypes 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		CAB_Get_STR_Transactions
		
		If (Records in selection:C76([Invoices:5])=0)
			myAlert("There are not STR transactions on data range")
		End if 
		
End case 
