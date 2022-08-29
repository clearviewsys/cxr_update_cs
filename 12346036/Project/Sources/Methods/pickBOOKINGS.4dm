//%attributes = {}
// PickBooking (->object; {force})
// ([Bookings];"Pick")

C_POINTER:C301($self; $1)
C_BOOLEAN:C305($forceDialog; $2)

Case of 
	: (Count parameters:C259=0)
		$self:=->[Bookings:50]BookingID:1
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

pickRecordForTable(->[Bookings:50]; ->[Bookings:50]BookingID:1; $self; False:C215; $forceDialog)