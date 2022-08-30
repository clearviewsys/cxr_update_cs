//%attributes = {}
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


READ ONLY:C145([Currencies:6])
QUERY:C277([Currencies:6]; [Currencies:6]isDisplayOnly:33=False:C215)
pickRecordForTable(->[Currencies:6]; ->[Currencies:6]CurrencyCode:1; $1; True:C214; $forceDialog)
//[Currencies];"Pick"