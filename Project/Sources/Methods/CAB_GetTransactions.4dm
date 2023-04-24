//%attributes = {}
// CAB_GetTransactions

C_DATE:C307($1; $dateRef)

Case of 
	: (Count parameters:C259=1)
		$dateRef:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($msg)

READ ONLY:C145([CompanyInfo:7])
ALL RECORDS:C47([CompanyInfo:7])

Case of 
		
	: (cboReportType=1)
		CAB_Get_STR_Transactions
End case 

FORM GOTO PAGE:C247(1)
