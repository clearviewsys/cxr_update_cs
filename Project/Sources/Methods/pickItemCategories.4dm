//%attributes = {}
C_POINTER:C301($1; $self)
C_BOOLEAN:C305($2; $forceDialog)

Case of 
	: (Count parameters:C259=0)
		$self:=->[Items:39]Category:3
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

pickRecordForTable(->[ItemCategories:45]; ->[ItemCategories:45]ItemCategory:1; $self; False:C215; $forceDialog)
//pickRecordForTable (->[ItemCategories];->[ItemCategories]ItemCategory;$1)