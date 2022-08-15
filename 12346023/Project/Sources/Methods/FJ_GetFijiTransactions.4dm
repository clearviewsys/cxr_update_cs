//%attributes = {}
// FJ_GetFijiTransactions

C_TEXT:C284($msg)

Case of 
		
	: (cboReportType=1)
		//GAML_Get_LCT_Transactions (initialDate;finalDate)
		FJ_Get_CTR_Transactions(initialDate)
		
		
		If (Records in selection:C76([Invoices:5])=0)
			// There are not transactions that can be reported as CTR on the date requested.
			$msg:="There are not invoices that can be reported to FIU on the dates requested."
			checkAddError($msg)
			
		End if 
		
		
	: (cboReportType=2)
		//FJ_Get_eWires_Transactions (initialDate;finalDate)
		FJ_Get_eWires_Transactions(initialDate)
		
		
		If (Records in selection:C76([eWires:13])=0)
			$msg:="There are not eWires EFTR transactions to be reported on the dates requested."
			checkAddError($msg)
		End if 
		
	: (cboReportType=3)
		FJ_Get_Wires_Transactions(initialDate)
		
		
		If (Records in selection:C76([Wires:8])=0)
			$msg:="There are not Wires EFTR transactions to be reported on the dates requested."
			checkAddError($msg)
		End if 
		
		
End case 

