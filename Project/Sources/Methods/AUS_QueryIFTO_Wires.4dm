//%attributes = {}

// AUS_QueryIFTO_Wires ($fromDate; $toDate; {isOutgoing:true} )


C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isOutgoing; $3)
C_REAL:C285($limit)
$limit:=<>THRESHOLDFORPTRTRANSFERS
$isOutgoing:=True:C214
READ ONLY:C145([Customers:3])
READ ONLY:C145([Wires:8])

Case of 
	: (Count parameters:C259=0)
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
		
	: (Count parameters:C259=2)
		$fromDate:=$1
		$toDate:=$2
		
	: (Count parameters:C259=3)
		$fromDate:=$1
		$toDate:=$2
		$isOutgoing:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($country)
$country:=keyValue_getValue("AML.Reporting.CountryCode")

// Get all invoices in that period of time
READ ONLY:C145([Wires:8])
READ ONLY:C145([Invoices:5])

// Search only Wire transfer 
QUERY:C277([Wires:8]; [Wires:8]WireTransferDate:17>=$fromDate; *)
QUERY:C277([Wires:8];  & ; [Wires:8]WireTransferDate:17<=$fromDate)

RELATE ONE SELECTION:C349([Wires:8]; [Invoices:5])
QUERY SELECTION:C341([Invoices:5];  & ; [Invoices:5]isCancelled:84=False:C215)
FIRST RECORD:C50([Invoices:5])


While (Not:C34(End selection:C36([Invoices:5])))
	QUERY:C277([Wires:8]; [Wires:8]CXR_InvoiceID:12=[Invoices:5]InvoiceID:1)
	
	If (Records in selection:C76([Wires:8])>0)
		If ((isCustomerReportable([Invoices:5]CustomerID:2)) & ([Wires:8]AmountLocal:25>=$limit))
			ADD TO SET:C119([Wires:8]; "eft")
		End if 
	End if 
	
	NEXT RECORD:C51([Invoices:5])
End while 

FIRST RECORD:C50([Wires:8])
