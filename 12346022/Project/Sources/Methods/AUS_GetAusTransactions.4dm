//%attributes = {}
// FJ_GetFijiTransactions

C_TEXT:C284($msg)

Case of 
		
	: (cboReportType=1)
		//GAML_Get_LCT_Transactions (initialDate;finalDate)
		AUS_Get_TTR_Transactions(initialDate)
		FORM GOTO PAGE:C247(1)
		
		
		If (Size of array:C274(arrFTRegisterID)=0)
			// There are not transactions that can be reported as LCT on the date requested.
			$msg:="There are not transactions that can be reported to goAML on the dates requested."
			checkAddError($msg)
		End if 
		
		
	: (cboReportType=2)
		AUS_Get_IFTI_DRA_Transactions(initialDate; finalDate)
		FORM GOTO PAGE:C247(2)
		
		
		If (Records in selection:C76([eWires:13])=0)
			$msg:="There are not eWire PTR transactions to be reported on the dates requested."
			checkAddError($msg)
		End if 
		
	: (cboReportType=3)
		AUS_Get_SMR_Transactions(initialDate; finalDate)
		FORM GOTO PAGE:C247(3)
		
		If (Records in selection:C76([Wires:8])=0)
			$msg:="There are not Wire PTR transactions to be reported on the dates requested."
			checkAddError($msg)
		End if 
		
		
End case 

