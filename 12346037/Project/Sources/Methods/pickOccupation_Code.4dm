//%attributes = {}
C_POINTER:C301($self; $1)
C_BOOLEAN:C305($forceDialog; $2)

Case of 
	: (Count parameters:C259=0)
		$self:=->[Customers:3]Occupation:21
		$forceDialog:=True:C214
		
	: (Count parameters:C259=1)
		$self:=$1
		$forceDialog:=False:C215
	: (Count parameters:C259=2)
		$self:=$1
		$forceDialog:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//SET FIELD RELATION([Occupations]CategoryCode;Automatic;Structure configuration)
pickRecordForTable(->[Occupations:2]; ->[Occupations:2]Code:2; $self; False:C215; $forceDialog)
//SET FIELD RELATION([Occupations]CategoryCode;Structure configuration;Structure configuration)

