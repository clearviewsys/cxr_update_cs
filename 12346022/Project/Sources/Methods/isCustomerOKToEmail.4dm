//%attributes = {}
// Takes customer ID and Returns whether the customer should be emailed Marketing Materials
//@viktor

// Unit test is written @Viktor


C_TEXT:C284($1; $customerID)
C_OBJECT:C1216($customer)
C_BOOLEAN:C305($0; $isNotOkayToEmail)
C_LONGINT:C283($numMonths)
C_TEXT:C284($numMonthsText)

Case of 
	: (Count parameters:C259=0)
		$customerID:=[Customers:3]CustomerID:1
		$customer:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()
	: (Count parameters:C259=1)
		$customerID:=$1
		$customer:=ds:C1482.Customers.query("CustomerID = :1"; $customerID).first()
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($customer#Null:C1517)
	
	//// Get Key Value 
	//$numMonthsText:=getKeyValue("email.stop.marketing.after.inactive.months";"12")
	//// Check if zero because it was set to zero, or because and error occured
	//If ((Num($numMonthsText)=0))
	//If ($numMonthsText="0")
	//$numMonths:=0
	//Else 
	//$numMonths:=12
	//End if 
	//Else 
	//$numMonths:=Num($numMonthsText)
	//End if 
	
	$isNotOkayToEmail:=$customer.isWalkin | \
		$customer.isOnHold | \
		($customer.optInEmail=2) | \
		($customer.Email="") | \
		$customer.isInsider | \
		($customer.AML_isInBusinessRelation=2)  // | (Add to date(getCustomerLastInvoiceDate($customerID);0;$numMonths;0)<Current date(*))\
		
Else 
	$isNotOkayToEmail:=True:C214
End if 
$0:=Not:C34($isNotOkayToEmail)