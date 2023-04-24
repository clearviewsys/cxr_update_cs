//%attributes = {}
// isCustomerSubjectToScreening ( {customerID} ) : boolean
// should return true if the customer is subject to sanction lists and PEP screening
// returns false otherwise
// written by @tiran on Jan 10 / 2021

// PRE: Customer Record shall be selected (current record)  if no parameter is passed
// POST: the selection of record in Customers will not be modified #ORDA #ordaquery

//Unit Test written by @ Wia kin @Tiran @Zoya
//@ Feb 07 /2021


C_TEXT:C284($1; $customerID)
C_OBJECT:C1216($customer)
C_BOOLEAN:C305($0; $doScreening)

Case of 
		
	: (Count parameters:C259=1)
		$customerID:=$1
		$customer:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
If ($customer#Null:C1517)
	$doScreening:=$customer.isWalkin | \
		$customer.isAccount | \
		($customer.AML_isWhitelisted & ($customer.AML_WhitelistExpiryDate>Current date:C33)) | \
		$customer.AML_ignoreKYC | \
		$customer.isInsider
	//ALERT($customer.AML_isWhitelisted)
	//ALERT($customer.AML_WhitelistExpiryDate)
	
Else 
	$doScreening:=False:C215  // by default check the name for screening 
End if 
$0:=Not:C34($doScreening)