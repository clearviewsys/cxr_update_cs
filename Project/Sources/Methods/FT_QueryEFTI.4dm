//%attributes = {}

// FT_queryEFTI ($fromDate; $toDate; {isOutgoing:false} )


C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isOutgoing; $3)
C_REAL:C285($limit)
$limit:=<>THRESHOLDFORPTRTRANSFERS
$isOutgoing:=False:C215
READ ONLY:C145([Customers:3])
READ ONLY:C145([eWires:13])

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


QUERY:C277([Customers:3]; [Customers:3]isInsider:102=False:C215)  // we don't want insider
RELATE MANY SELECTION:C340([eWires:13]CustomerID:15)  // select all eWires belonging to non-insiders

QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=False:C215; *)  // first query incoming eWires
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]SendDate:2>=$fromDate; *)  // then filter by date range
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]SendDate:2<=$toDate)


QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)

CREATE SET:C116([eWires:13]; "set1")

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45>=$limit; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="IRR"; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="TOM")
CREATE SET:C116([eWires:13]; "set2")

// Include wires if the currency is IRR or TOM

USE SET:C118("set1")
QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45<=$limit; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="IRR"; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="TOM")
CREATE SET:C116([eWires:13]; "set3")

UNION:C120("set2"; "set3"; "ifti")

CLEAR SET:C117("set1")
CLEAR SET:C117("set2")
CLEAR SET:C117("set3")

USE SET:C118("ifti")