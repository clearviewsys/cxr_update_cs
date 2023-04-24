//%attributes = {}
// AUS_QueryIFT
// query Overseas Transfers

C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isForcedReport; $3)
C_REAL:C285($limit)

$limit:=<>THRESHOLDFORPTRTRANSFERS
$isForcedReport:=False:C215

READ ONLY:C145([eWires:13])
READ ONLY:C145([Customers:3])

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
		$isForcedReport:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


QUERY:C277([eWires:13]; [eWires:13]SendDate:2>=$fromDate; *)
QUERY:C277([eWires:13];  & ; [eWires:13]SendDate:2<=$toDate)

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45>=$limit)
QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)
QUERY SELECTION:C341([eWires:13]; [eWires:13]wasReported:117=False:C215)

ARRAY TEXT:C222($arr; 0)

While (Not:C34(End selection:C36([eWires:13])))
	
	If (isCustomerReportable([eWires:13]CustomerID:15))
		APPEND TO ARRAY:C911($arr; [eWires:13]eWireID:1)
	End if 
	
	NEXT RECORD:C51([eWires:13])
	
End while 

QUERY WITH ARRAY:C644([eWires:13]eWireID:1; $arr)
ORDER BY:C49([eWires:13]; [eWires:13]eWireID:1)

