//%attributes = {}
// pickRelationTypes(object; forceDialog)

C_POINTER:C301($1; $self)
C_BOOLEAN:C305($forceDialog; $2)

Case of 
	: (Count parameters:C259=0)
		$self:=->[RelationTypes:156]relationTypeID:1
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

pickRecordForTable(->[RelationTypes:156]; ->[RelationTypes:156]relationTypeID:1; $self; True:C214; $forceDialog)
