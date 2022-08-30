//%attributes = {}
// FJ_GetTransactionsOnDate

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
		FJ_Get_CTR_Transactions($dateRef)
		FORM GOTO PAGE:C247(1)
		
		
	: (cboReportType=2)
		
		FJ_Get_eWires_Transactions($dateRef)
		FORM GOTO PAGE:C247(2)
		
		
	: (cboReportType=3)
		FJ_Get_Wires_Transactions($dateRef)
		FORM GOTO PAGE:C247(3)
		
End case 

