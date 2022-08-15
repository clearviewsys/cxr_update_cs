//%attributes = {}
// AUS_GetTransactionsOnDate

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
		AUS_Get_TTR_Transactions($dateRef)
		FORM GOTO PAGE:C247(1)
		
		
	: (cboReportType=2)
		
		AUS_Get_IFTI_DRA_Transactions($dateRef)
		FORM GOTO PAGE:C247(2)
		
		
	: (cboReportType=3)
		AUS_Get_SMR_Transactions($dateRef)
		FORM GOTO PAGE:C247(3)
		
End case 

