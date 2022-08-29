//%attributes = {}
// pickCustomer (->object; {force})
// ([Customers];"Pick")

C_POINTER:C301($self; $1)
C_BOOLEAN:C305($forceDialog; $2)
C_TEXT:C284($0)

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

OK:=1  //init

pickRecordForTable(->[Customers:3]; ->[Customers:3]CustomerID:1; $self; False:C215; $forceDialog)
If (OK=1)
	$0:=[Customers:3]CustomerID:1
End if 