C_POINTER:C301(browseTablePtr)
handleListForm
If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrValue; 0)
	ARRAY TEXT:C222(arrKey; 0)
	handleBTABbrowseTables
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([LinkedDocs:4])
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([Registers:10])
	READ ONLY:C145([eWires:13])
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (arrKey>0)
		//vSearchText:=arrKey{arrKey}
		GOTO SELECTED RECORD:C245(browseTablePtr->; arrKey)
		//handleBTabBrowseForms
	End if 
	
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	displayCurrentRecord(browseTablePtr)
End if 

Case of 
	: (Table:C252(browseTablePtr)=Table:C252(->[Customers:3]))
		//QUERY([PictureIDs];[PictureIDs]CustomerID=[Customers]CustomerID)
		//ORDER BY([PictureIDs];[PictureIDs]ExpiryDate;>)
		//FIRST RECORD([PictureIDs])
		
	: (Table:C252(browseTablePtr)=Table:C252(->[Invoices:5]))
		RELATE ONE:C42([Invoices:5]CustomerID:2)
		RELATE ONE:C42([Invoices:5]eWireID:23)
		RELATE MANY:C262([Invoices:5]InvoiceID:1)  // select all related registers
		C_REAL:C285(vFromAmount; vToAmount; vFromBalance; vToBalance)
		C_PICTURE:C286(vFromFlag; vToFlag)
		If (Records in selection:C76([Invoices:5])>0)
			calcInvoiceVars(->vFromAmount; ->vToAmount; ->vFromBalance; ->vToBalance)
			setFlagPicture(->vFromFlag; [Invoices:5]fromCurrency:3)
			setFlagPicture(->vToFlag; [Invoices:5]toCurrency:8)
		Else 
			initializeCalculator
			vFromBalance:=0
			vToBalance:=0
		End if 
	: (Table:C252(browseTablePtr)=Table:C252(->[Registers:10]))
		RELATE ONE:C42([Registers:10]CustomerID:5)
		
	: (Table:C252(browseTablePtr)=Table:C252(->[eWires:13]))
		RELATE ONE:C42([eWires:13]LinkID:8)
		
	: (Table:C252(browseTablePtr)=Table:C252(->[Links:17]))
		RELATE ONE:C42([Links:17]CustomerID:14)
		
End case 
