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

pickRecordForTable(->[Signatures:141]; ->[Signatures:141]Signature:3; $1; True:C214; $forceDialog)