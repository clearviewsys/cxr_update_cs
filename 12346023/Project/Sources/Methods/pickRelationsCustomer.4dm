//%attributes = {}
//pickRelationsCustomer (->fieldPtr;objectFullName)

C_POINTER:C301(fieldPtr; $1; $ptr)
C_TEXT:C284($2; objectFullName)

If (Count parameters:C259=2)
	fieldPtr:=$1
	objectFullName:=$2
Else 
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

fieldPtr->:=pickCustomer(fieldPtr)
$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; objectFullName)
$ptr->:=getCustomerFullNameORDA(fieldPtr->)