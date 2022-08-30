//%attributes = {}
C_POINTER:C301($1)
C_BOOLEAN:C305($2)
Case of 
	: (Count parameters:C259=1)
		pickRecordForTable(->[CompanyTypes:161]; ->[CompanyTypes:161]Code:1; $1)
	: (Count parameters:C259=2)
		pickRecordForTable(->[CompanyTypes:161]; ->[CompanyTypes:161]Code:1; $1; True:C214; $2)
End case 