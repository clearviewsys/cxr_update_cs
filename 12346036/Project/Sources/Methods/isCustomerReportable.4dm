//%attributes = {}
// isCustomerReportable
// Checks if the customer is reportable for a LCTR Report

C_TEXT:C284($1; $customerID)
C_BOOLEAN:C305($0)

Case of 
	: (Count parameters:C259=1)
		$customerID:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Customers:3])
QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)
If (Records in selection:C76([Customers:3])=1)
	
	If (isCustomerSelfOrWalkIn([Customers:3]CustomerID:1) | ([Customers:3]isWholesaler:87) | ([Customers:3]isInsider:102) | ([Customers:3]isMSB:85) | ([Customers:3]AML_doNotReport:153))
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 
Else 
	$0:=False:C215
End if 

