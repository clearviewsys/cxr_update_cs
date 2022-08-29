//%attributes = {}
// createLinkForCustomer(CustomerID;{AuthorizedUSer})

C_TEXT:C284($1; $2)
C_TEXT:C284(vCustomerID; vAuthorizedUser)
vAuthorizedUser:=""

vCustomerID:=$1
If (Count parameters:C259)=2
	vAuthorizedUser:=$2
End if 
newRecordLinks