//%attributes = {}
RELATE ONE:C42([Invoices:5]CustomerID:2)

If (Records in selection:C76([Customers:3])=0)
	CREATE RELATED ONE:C65([Invoices:5]CustomerID:2)
	[Customers:3]CustomerID:1:=[Invoices:5]CustomerID:2
	[Customers:3]FullName:40:=[Invoices:5]CustomerFullName:54
	[Customers:3]FirstName:3:=[Invoices:5]CustomerFullName:54
	[Customers:3]isFavorite:68:=True:C214
	[Customers:3]CreatedByUserID:58:="system"
	//[Customers]:=[Invoices]CustomerFINTRACNotes
	[Customers:3]HomeTel:6:=[Invoices:5]CustomerMainPhone:61
	[Customers:3]Address:7:=[Invoices:5]CustomerFullAddress:59
	[Customers:3]Occupation:21:=[Invoices:5]CustomerOccupation:60
	
	[Customers:3]PictureID_Number:69:=[Invoices:5]CustomerPictureID:55
	[Customers:3]PictureID_Type:70:=[Invoices:5]CustomerPictureIDType:56
	[Customers:3]PictureID_ExpiryDate:71:=[Invoices:5]CustomerPictureIDExpDate:57
	[Customers:3]PictureID_IssueState:72:=[Invoices:5]CustomerPictureIDPlaceOfIssue:58
	
	[Customers:3]Comments:43:="This customer profile was recreated automatically using invoice "+[Invoices:5]InvoiceID:1+CRLF+[Invoices:5]CustomerPrivateRemarks:63
	[Customers:3]AML_RiskRating:75:=[Invoices:5]CustomerRiskRating:62
	
	
	SAVE RELATED ONE:C43([Invoices:5]CustomerID:2)
End if 
