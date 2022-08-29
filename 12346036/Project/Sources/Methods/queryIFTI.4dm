//%attributes = {}
// queryIFTI
// query incoming IFT

C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isForcedReport; $3)
C_REAL:C285($4; $limit)
$limit:=0
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
	: (Count parameters:C259=4)
		$fromDate:=$1
		$toDate:=$2
		$isForcedReport:=$3
		$limit:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


CREATE EMPTY SET:C140([eWires:13]; "$set1")

QUERY:C277([eWires:13]; [eWires:13]ReceiveDate:18>=$fromDate; *)
QUERY:C277([eWires:13];  & ; [eWires:13]ReceiveDate:18<=$toDate)
// first query Incoming eWires
QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=False:C215)  // received
QUERY SELECTION:C341([eWires:13]; [eWires:13]isSettled:23=True:C214)  // Settled 

QUERY SELECTION:C341([eWires:13]; [eWires:13]toCountryCode:112=<>COUNTRYCODE; *)  // IFT (from <>COUNTRYCODE to other country)
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]fromCountryCode:111#<>COUNTRYCODE)

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45>=$limit)
QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)


FIRST RECORD:C50([eWires:13])


While (Not:C34(End selection:C36([eWires:13])))
	
	If (isCustomerReportable([eWires:13]CustomerID:15))
		ADD TO SET:C119([eWires:13]; "$set1")
	End if 
	
	NEXT RECORD:C51([eWires:13])
End while 

USE SET:C118("$set1")
CLEAR SET:C117("set1")
