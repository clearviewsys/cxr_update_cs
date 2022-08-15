//%attributes = {}
// pickeWireForCustomer (->obj; customerID)

C_POINTER:C301($1; $self)
C_TEXT:C284($2; theCustomerID; $eWireID)

Case of 
	: (Count parameters:C259=0)
		$self:=->$eWireID
		theCustomerID:="QSCUS1029204"
		pickCustomer(->theCustomerID)
		
	: (Count parameters:C259=2)
		$self:=$1
		theCustomerID:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickeWire($self; "selecteWiresReceivedForCustomer")
//pickaccounts