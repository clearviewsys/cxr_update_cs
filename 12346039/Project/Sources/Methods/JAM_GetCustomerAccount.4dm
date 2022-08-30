//%attributes = {}
// JAM_GetCustomerAccount ($customerID)
// Author JA


C_TEXT:C284($0; $1; $customerID)

Case of 
	: (Count parameters:C259=1)
		$customerID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$0:="777845"  // Return JMD Account

