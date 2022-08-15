//%attributes = {}

// FT_queryEFTO_NS ($fromDate; $toDate; {isOutgoing:true} )


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

QUERY:C277([Customers:3]; [Customers:3]isInsider:102=False:C215)  // we don't want insider
RELATE MANY SELECTION:C340([Wires:8]CustomerID:2)  // select all Wires belonging to non-insiders

QUERY SELECTION:C341([Wires:8]; [Wires:8]isOutgoingWire:16=$isOutgoing; *)  // first query outgoing Wires
QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]WireTransferDate:17>=$fromDate; *)  // then filter by date range
QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]WireTransferDate:17<=$toDate)

CREATE SET:C116([Wires:8]; "$set1")

QUERY SELECTION:C341([Wires:8]; [Wires:8]AmountLocal:25>=$limit; *)
QUERY SELECTION:C341([Wires:8];  | ; [Wires:8]Currency:15="IRR"; *)
QUERY SELECTION:C341([Wires:8];  | ; [Wires:8]Currency:15="TOM")

CREATE SET:C116([Wires:8]; "$set2")
// Include wires if the currency is IRR or TOM

USE SET:C118("$set1")
FIRST RECORD:C50([Wires:8])

QUERY SELECTION:C341([Wires:8]; [Wires:8]AmountLocal:25<=$limit; *)
QUERY SELECTION:C341([Wires:8];  | ; [Wires:8]Currency:15="IRR"; *)
QUERY SELECTION:C341([Wires:8];  | ; [Wires:8]Currency:15="TOM")

CREATE SET:C116([Wires:8]; "$set3")

UNION:C120("$set2"; "$set3"; "efto")

CLEAR SET:C117("$set1")
CLEAR SET:C117("$set2")
CLEAR SET:C117("$set3")

USE SET:C118("efto")
FIRST RECORD:C50([Wires:8])
