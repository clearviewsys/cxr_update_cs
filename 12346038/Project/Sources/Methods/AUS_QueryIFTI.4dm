//%attributes = {}

// query incoming IFT

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

C_TEXT:C284($countryCode)

QUERY:C277([Customers:3]; [Customers:3]isInsider:102=False:C215)  // we don't want insider
RELATE MANY SELECTION:C340([eWires:13]CustomerID:15)  // select all eWires belonging to non-insiders

// first query outgoing eWires
QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=False:C215)  // received
QUERY SELECTION:C341([eWires:13]; [eWires:13]isSettled:23=True:C214)  // Settled 

QUERY SELECTION:C341([eWires:13]; [eWires:13]ReceiveDate:18>=$fromDate; *)
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]ReceiveDate:18<=$toDate)
$countryCode:=keyValue_getValue("AML.Reporting.CountryCode")
QUERY SELECTION:C341([eWires:13]; [eWires:13]toCountryCode:112=$countryCode; *)  // IFT (from other country to NZ)
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]fromCountryCode:111#$countryCode)

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45>=$limit)
QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)
//If ($isForcedReport=False)
QUERY SELECTION:C341([eWires:13]; [eWires:13]wasReported:117=False:C215)
//End if 