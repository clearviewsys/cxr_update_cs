//%attributes = {}
// updateSanctionListCallsLimit ($list)
// Decreases the number of Sanction List calls for a Client

C_TEXT:C284($1; $list)


Case of 
		
	: (Count parameters:C259=1)
		$list:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: ($list="PEP")
		
		ALL RECORDS:C47([CompanyInfo:7])
		READ WRITE:C146([CompanyInfo:7])
		[CompanyInfo:7]MaxPEPSanctionListCalls:27:=[CompanyInfo:7]MaxPEPSanctionListCalls:27-1
		SAVE RECORD:C53([CompanyInfo:7])
		READ ONLY:C145([CompanyInfo:7])
		
End case 
