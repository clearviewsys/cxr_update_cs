//%attributes = {}
C_POINTER:C301($1; $self)

C_TEXT:C284($test)
Case of 
	: (Count parameters:C259=0)
		$self:=->$test
	: (Count parameters:C259=1)
		$self:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickeWire($self; "selecteWiresReceivedPending")
//pickaccounts


