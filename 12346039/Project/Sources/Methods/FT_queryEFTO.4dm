//%attributes = {}

// FT_queryEFTO ($fromDate; $toDate; {isOutgoing:true} )


C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isOutgoing; $3)
C_REAL:C285($limit)
$limit:=<>THRESHOLDFORPTRTRANSFERS
$isOutgoing:=True:C214
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
QUERY:C277([Customers:3];  & ; [Customers:3]isMSB:85=False:C215; *)
QUERY:C277([Customers:3];  & ; [Customers:3]isWholesaler:87=False:C215)

RELATE MANY SELECTION:C340([eWires:13]CustomerID:15)  // select all eWires belonging to non-insiders

QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=$isOutgoing; *)  // first query outgoing eWires
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]SendDate:2>=$fromDate; *)  // then filter by date range
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]SendDate:2<=$toDate)


// QUERY SELECTION([eWires];[eWires]fromCountryCode=$country;*)  // EFT (from CA to other country)
// QUERY SELECTION([eWires]; & ;[eWires]toCountryCode#$country)

QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)
//QUERY SELECTION([eWires];[eWires]wasReported=False)

CREATE SET:C116([eWires:13]; "$set1")

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45>=$limit; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="IRR"; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="TOM")
CREATE SET:C116([eWires:13]; "$set2")
// Include wires if the currency is IRR or TOM

USE SET:C118("$set1")
FIRST RECORD:C50([eWires:13])

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45<=$limit; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="IRR"; *)
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]Currency:12="TOM")

CREATE SET:C116([eWires:13]; "$set3")

UNION:C120("$set2"; "$set3"; "efto")

CLEAR SET:C117("$set1")
CLEAR SET:C117("$set2")
CLEAR SET:C117("$set3")

USE SET:C118("efto")
FIRST RECORD:C50([eWires:13])
