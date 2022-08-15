//%attributes = {}
//handleShowCustomerNamesButton (self; ->oneField)
// e.g.  handleShowCustomerNamesButton (self; ->[cheques]customerID)

C_POINTER:C301($fieldPtr; $self; $1; $2)

Case of 
	: (Count parameters:C259=2)
		$self:=$1
		$fieldPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


handleCB_relateOne($self; $fieldPtr)
If ($self->=0)
	REDUCE SELECTION:C351([Customers:3]; 0)
End if 