//%attributes = {}


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		setNextCustomer([WebEWires:149]CustomerID:21)
		newRecordInvoices
		initNextCustomer
	Else 
		If ([WebEWires:149]status:16=20)
			Case of 
				: ([WebEWires:149]paymentInfo:35.invoiceID=Null:C1517)
					OBJECT SET VISIBLE:C603(*; "invoiceNewBtn"; True:C214)
					OBJECT SET ENABLED:C1123(*; "invoiceNewBtn"; True:C214)
					OBJECT SET VISIBLE:C603(*; "invoiceNumber@"; False:C215)
				: ([WebEWires:149]paymentInfo:35.invoiceID="")
					OBJECT SET VISIBLE:C603(*; "invoiceNewBtn"; True:C214)
					OBJECT SET ENABLED:C1123(*; "invoiceNewBtn"; True:C214)
					OBJECT SET VISIBLE:C603(*; "invoiceNumber@"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "invoiceNewBtn"; False:C215)
					OBJECT SET VISIBLE:C603(*; "invoiceNumber@"; True:C214)
			End case 
		Else 
			OBJECT SET VISIBLE:C603(*; "invoiceNewBtn"; False:C215)
			OBJECT SET VISIBLE:C603(*; "invoiceNumber@"; True:C214)
		End if 
		
End case 