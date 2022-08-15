//%attributes = {}
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
Case of 
	: (Count parameters:C259=1)
		pickRecordForTable(->[AML_Alerts:137]; ->[AML_Alerts:137]alertID:2; $1)
	: (Count parameters:C259=2)
		pickRecordForTable(->[AML_Alerts:137]; ->[AML_Alerts:137]alertID:2; $1; True:C214; $2)
End case 