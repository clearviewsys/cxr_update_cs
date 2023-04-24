//%attributes = {}
var $success : Boolean

var $es : Object
var $customer : Object

//QUERY([Customers]; [Customers]FullName=" ")
//QUERY([Customers]; [Customers]approvalStatus=-9999)
$es:=ds:C1482.Customers.query("approvalStatus == -9999")

$success:=True:C214

For each ($customer; $es)
	
	If (Length:C16($customer.CustomerID)<9)
		$success:=$success & (CAB_queryCustomerID(String:C10(Num:C11($customer.CustomerID); "000000000")))
	Else 
		$success:=$success & (CAB_queryCustomerID($customer.CustomerID))
	End if 
	
End for each 
