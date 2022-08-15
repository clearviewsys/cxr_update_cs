//%attributes = {}
// checkSanctionListCallsAvailable ($list)
// Check if there are call availables for a $list Sanction List 

C_BOOLEAN:C305($0)
C_TEXT:C284($1; $list)

Case of 
		
	: (Count parameters:C259=1)
		$list:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: ($list="PEP")
		READ ONLY:C145([CompanyInfo:7])
		ALL RECORDS:C47([CompanyInfo:7])
		$0:=([CompanyInfo:7]MaxPEPSanctionListCalls:27>0)
	Else 
		// In the future we will have more sanction list limits
		$0:=True:C214
End case 
