//%attributes = {}
C_TEXT:C284($buttonName; $1)

Case of 
	: (Count parameters:C259=1)
		$buttonName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

OBJECT SET ENABLED:C1123(*; $buttonName; True:C214)
