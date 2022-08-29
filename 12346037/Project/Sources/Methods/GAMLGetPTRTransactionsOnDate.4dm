//%attributes = {}
//GAML_GetPTRTransactionsOnDate ($refDate)

C_DATE:C307($1; $dateRef)

Case of 
	: (Count parameters:C259=1)
		$dateRef:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($msg)


Case of 
		
	: (cboReportType=1)
		
		GAML_Get_LCT_Transactions($dateRef)
		FORM GOTO PAGE:C247(1)
		
		
	: (cboReportType=2)
		//GAML_Get_eWires_Transactions (initialDate;finalDate)
		GAML_Get_eWires_Transactions($dateRef)
		FORM GOTO PAGE:C247(2)
		
		
	: (cboReportType=3)
		GAML_Get_Wires_Transactions($dateRef)
		FORM GOTO PAGE:C247(3)
		
End case 

