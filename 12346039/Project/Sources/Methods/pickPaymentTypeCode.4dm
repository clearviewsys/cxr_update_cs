//%attributes = {}
// pickPaymentTypeCode (->object; {force})

C_POINTER:C301($self; $1)
C_BOOLEAN:C305($forceDialog; $2)

Case of 
	: (Count parameters:C259=0)
		$self:=->[Accounts:9]CustomerID:20
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

pickRecordForTable(->[PaymentTypes:116]; ->[PaymentTypes:116]Code:2; $self; False:C215; $forceDialog)
//C_POINTER($1)
//pickRecordForTable (->[PaymentTypes];->[PaymentTypes]Code;$1)