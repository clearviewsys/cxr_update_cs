//%attributes = {}

// FT_queryEFTO_NS ($fromDate; $toDate; {isOutgoing:true} )


C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isOutgoing; $3)
C_REAL:C285($limit)
C_BOOLEAN:C305($relatedIran)

$relatedIran:=False:C215
$limit:=<>THRESHOLDFORPTRTRANSFERS


READ ONLY:C145([Customers:3])
READ ONLY:C145([Wires:8])

Case of 
	: (Count parameters:C259=0)
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
		$isOutgoing:=True:C214
		
	: (Count parameters:C259=2)
		$fromDate:=$1
		$toDate:=$2
		$isOutgoing:=True:C214
		
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
READ ONLY:C145([WireTemplates:42])

QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=$fromDate; *)  // first query outgoing Wires
QUERY:C277([Invoices:5];  & ; [Invoices:5]invoiceDate:44<=$toDate; *)  // then filter by date range
QUERY:C277([Invoices:5];  & ; [Invoices:5]isCancelled:84=False:C215)


FIRST RECORD:C50([Invoices:5])

CREATE EMPTY SET:C140([Wires:8]; "eft")

While (Not:C34(End selection:C36([Invoices:5])))
	
	QUERY:C277([Wires:8]; [Wires:8]CXR_InvoiceID:12=[Invoices:5]InvoiceID:1; *)
	QUERY:C277([Wires:8];  & ; [Wires:8]isOutgoingWire:16=$isOutgoing)
	
	
	If (Records in selection:C76([Wires:8])>0)
		FIRST RECORD:C50([Wires:8])
		While (Not:C34(End selection:C36([Wires:8])))
			
			$relatedIran:=(([Wires:8]Currency:15="IRR") | ([Wires:8]Currency:15="TOM") | ([Wires:8]BeneficiaryCountryCode:78="IR"))
			$relatedIran:=$relatedIran & (([WireTemplates:42]BankCountryCode:35="IR") | ([WireTemplates:42]BeneficiaryCountryCode:27="IR") | ([WireTemplates:42]BankCountry:12="IR"))
			
			If (isCustomerReportable([Invoices:5]CustomerID:2))
				
				Case of 
					: ($relatedIran)
						ADD TO SET:C119([Wires:8]; "eft")
						
					: ([Wires:8]AmountLocal:25>=$limit)
						ADD TO SET:C119([Wires:8]; "eft")
						
				End case 
				
			End if 
			
			NEXT RECORD:C51([Wires:8])
		End while 
		
	End if 
	
	NEXT RECORD:C51([Invoices:5])
End while 

//USE SET("$set1")

//QUERY SELECTION([Wires];[Wires]AmountLocal>=$limit;*)
//QUERY SELECTION([Wires]; | ;[Wires]Currency="IRR";*)
//QUERY SELECTION([Wires]; | ;[Wires]Currency="TOM")

//CREATE SET([Wires];"$set2")
//  // Include wires if the currency is IRR or TOM

//USE SET("$set1")
//FIRST RECORD([Wires])

//QUERY SELECTION([Wires];[Wires]AmountLocal<=$limit;*)
//QUERY SELECTION([Wires]; | ;[Wires]Currency="IRR";*)
//QUERY SELECTION([Wires]; | ;[Wires]Currency="TOM")

//CREATE SET([Wires];"$set3")

//UNION("$set2";"$set3";"eft")

//CLEAR SET("$set1")
//CLEAR SET("$set2")
//CLEAR SET("$set3")

USE SET:C118("eft")
FIRST RECORD:C50([Wires:8])
