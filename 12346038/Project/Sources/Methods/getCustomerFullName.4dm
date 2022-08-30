//%attributes = {}
//getCustomerFullName
C_TEXT:C284($0; $1)
C_TEXT:C284($customerID; $fullName)

If (Count parameters:C259>=1)
	$customerID:=$1
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)
Else 
	$customerID:=[Customers:3]CustomerID:1
End if 

If (Records in selection:C76([Customers:3])=1)
	$fullName:=[Customers:3]Salutation:2+" "+[Customers:3]FullName:40
Else 
	$fullName:=""
End if 

$0:=$fullName

