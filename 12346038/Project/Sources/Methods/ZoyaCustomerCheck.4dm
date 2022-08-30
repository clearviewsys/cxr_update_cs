//%attributes = {}
// ZoyaCustomerCheck ( {customerID} ) : boolean
// should return true if the customer is subject to sanction lists and PEP screening
// returns false otherwise
// written by @tiran on Jan 10 / 2021
//Update @Zoya Feb 07 / 2021

// PRE: Customer Record shall be selected (current record)  if no parameter is passed
// POST: the selection of record in Customers will not be modified #ORDA #ordaquery

//Unit Test written by @Zoya
//@ Feb 07 /2021


C_TEXT:C284($1; $customerID)
C_OBJECT:C1216($customer)
C_BOOLEAN:C305($0; $ignoreScreening)

Case of 
		
	: (Count parameters:C259=1)
		$customerID:=$1
		$customer:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$ignoreScreening:=False:C215  // by default check the name for screening
If ($customer#Null:C1517)
	If ($customer.AML_isWhitelisted)
		$ignoreScreening:=$customer.AML_WhitelistExpiryDate>Current date:C33
	Else 
		$ignoreScreening:=$customer.isWalkin | $customer.isAccount | $customer.AML_ignoreKYC | $customer.isInsider
		
	End if 
	
	$0:=Not:C34($ignoreScreening)
Else 
	$0:=False:C215
End if 
