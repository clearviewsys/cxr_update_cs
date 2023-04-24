//%attributes = {}
// pickList_RiskFactor ( object; forceDialog)
C_POINTER:C301($1)
C_BOOLEAN:C305($forceDialog; $2)

Case of 
	: (Count parameters:C259=0)
		$forceDialog:=True:C214
	: (Count parameters:C259=1)
		$forceDialog:=False:C215
	: (Count parameters:C259=2)
		$forceDialog:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickRecordForTable(->[List_RiskFactors:132]; ->[List_RiskFactors:132]Code:2; $1; True:C214; $forceDialog)
REDUCE SELECTION:C351([List_RiskFactors:132]; 0)