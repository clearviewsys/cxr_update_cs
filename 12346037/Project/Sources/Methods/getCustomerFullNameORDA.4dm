//%attributes = {}
//getCustomerFullNameORDA ($CustomerID) ->returnFullName
//#ORDA

C_TEXT:C284($0; $1)
C_TEXT:C284($customerID; $fullName)
$customerID:=$1
C_OBJECT:C1216($results)
$results:=ds:C1482.Customers.query("CustomerID = :1"; $customerID)
If ($results.length>=1)
	$fullName:=$results.FullName[0]
Else 
	$fullName:=""
End if 
$0:=$fullName