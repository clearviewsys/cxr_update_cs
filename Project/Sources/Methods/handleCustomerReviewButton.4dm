//%attributes = {}
// handleCustomerReviewButton

C_TEXT:C284($customerID; $1)
C_BOOLEAN:C305($doQuery; $2)

$doQuery:=True:C214
Case of 
	: (Count parameters:C259=0)
		$customerID:=[Customers:3]CustomerID:1
	: (Count parameters:C259=1)
		$customerID:=$1
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$doQuery:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (isUserAuthorizedToModify(->[Customers:3]))
	
	If ($doQuery)
		READ ONLY:C145([Customers:3])
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)  // reload the record in case some information was changed
	End if 
	If (Records in selection:C76([Customers:3])=1)
		If (Not:C34([Customers:3]isWalkin:36))
			modifyRecordTable(->[Customers:3]; "Review_KYC")
			If (OK=1)
				vSearchText:=[Customers:3]CustomerID:1
				//handleAutoFillSearch (->vSearchText;->[Customers];->[Customers]CustomerID;->[Customers]FullName;->[Customers]CustomerID;->arrKey;->arrValue)
			End if 
		End if 
		
	End if 
Else 
	myAlert("Sorry, you are not authorized to Review the customer's profile!")
End if 

