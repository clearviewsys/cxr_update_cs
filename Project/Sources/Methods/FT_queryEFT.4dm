//%attributes = {}

// FT_queryEFT ($fromDate; $toDate; {isOutgoing:true} )


C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isOutgoing; $3)
ARRAY TEXT:C222($arrEwires; 0)

C_REAL:C285($limit)
$limit:=<>THRESHOLDFORPTRTRANSFERS
$isOutgoing:=True:C214


READ ONLY:C145([Customers:3])
READ ONLY:C145([eWires:13])
READ ONLY:C145([Invoices:5])

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

QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=$fromDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=$toDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isCancelled:84=False:C215)

CREATE EMPTY SET:C140([eWires:13]; "eft")

ORDER BY:C49([Invoices:5]; [Invoices:5]invoiceDate:44)
FIRST RECORD:C50([Invoices:5])

While (Not:C34(End selection:C36([Invoices:5])))
	If (isCustomerReportable([Invoices:5]CustomerID:2))
		
		//QUERY([eWires];[eWires]InvoiceNumber=[Invoices]InvoiceID)
		
		QUERY:C277([eWires:13]; [eWires:13]InvoiceNumber:29=[Invoices:5]InvoiceID:1; *)
		QUERY:C277([eWires:13];  & ; [eWires:13]isPaymentSent:20=$isOutgoing; *)
		QUERY:C277([eWires:13];  & ; [eWires:13]isCancelled:34=False:C215)
		
		While (Not:C34(End selection:C36([eWires:13])))
			ADD TO SET:C119([eWires:13]; "eft")
			NEXT RECORD:C51([eWires:13])
		End while 
		
	End if 
	
	NEXT RECORD:C51([Invoices:5])
End while 

USE SET:C118("eft")
FIRST RECORD:C50([eWires:13])
