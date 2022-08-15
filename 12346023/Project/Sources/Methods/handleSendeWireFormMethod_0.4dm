//%attributes = {}
If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrPartnerBank; 0)
	
	If (vCustomerID#"")
		[eWires:13]InvoiceNumber:29:=vInvoiceNumber
		[eWires:13]isPaymentSent:20:=True:C214
		[eWires:13]fromCountry:9:=<>CompanyCountry
		[eWires:13]FromAmount:13:=vFromAmount
		[eWires:13]FromCurrency:11:=vFromCurrency
		[eWires:13]ToAmount:14:=vToAmount
		[eWires:13]Currency:12:=vToCurrency
		[eWires:13]eWireID:1:=makeeWireID
		
		QUERY:C277([Links:17]; [Links:17]CustomerID:14=vCustomerID)
		If (Records in selection:C76([Links:17])>0)
			SELECTION TO ARRAY:C260([Links:17]LinkID:1; arrLInkIDs; [Links:17]FullName:4; arrLinkNames; [Links:17]City:11; arrLinkCities)
			arrLinkIDs:=1  // select the first element
			arrLinkNames:=1
			arrLinkCities:=1
			handleLinkListArrays  // click on the first row and select it
		Else 
			ARRAY TEXT:C222(arrLinkIDs; 0)
			ARRAY TEXT:C222(arrLinkNames; 0)
			ARRAY TEXT:C222(arrLinkCities; 0)
		End if 
		
	Else 
		myAlert("Customer ID must be valid.")
		CANCEL:C270
	End if 
	
	arrPartnerBank:=0
	unloadRecordBanks
	
End if 

If (Form event code:C388=On Close Box:K2:21)
	FORM GOTO PAGE:C247(1)
End if 
