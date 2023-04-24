//%attributes = {}
// GAML_GetIFTO_Ewires
// query outgoing IFT

C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($isForcedReport; $3)
C_REAL:C285($4; $limit)
$limit:=0
$isForcedReport:=False:C215
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
		$isForcedReport:=$3
		
	: (Count parameters:C259=4)
		$fromDate:=$1
		$toDate:=$2
		$isForcedReport:=$3
		$limit:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

QUERY:C277([eWires:13]; [eWires:13]SendDate:2>=$fromDate; *)  // then filter by date range
QUERY:C277([eWires:13];  & ; [eWires:13]SendDate:2<=$toDate)
RELATE ONE SELECTION:C349([eWires:13]; [Customers:3])

QUERY SELECTION:C341([Customers:3]; [Customers:3]isWalkin:36=False:C215)  // filter out the Walk-in Customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]CustomerID:1#"000@")  // filter out the Walk-in Customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isInsider:102=False:C215)  // filter out the insider customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isMSB:85=False:C215)  // filter out the MSB
QUERY SELECTION:C341([Customers:3]; [Customers:3]isWholesaler:87=False:C215)  // filter out the Wholesalers
QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_doNotReport:153=False:C215)

RELATE MANY SELECTION:C340([eWires:13]CustomerID:15)  // select all eWires belonging to non-insiders


QUERY SELECTION:C341([eWires:13]; [eWires:13]SendDate:2>=$fromDate; *)  // then filter by date range
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]SendDate:2<=$toDate)

QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=True:C214)  // first query outgoing eWires

QUERY SELECTION:C341([eWires:13]; [eWires:13]fromCountryCode:111=<>COUNTRYCODE; *)  // IFT (from <>COUNTRYCODE to other country)
QUERY SELECTION:C341([eWires:13];  & ; [eWires:13]toCountryCode:112#<>COUNTRYCODE)

QUERY SELECTION:C341([eWires:13]; [eWires:13]amountLocal:45>=$limit)
QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)
//If ($isForcedReport=False)
QUERY SELECTION:C341([eWires:13]; [eWires:13]wasReported:117=False:C215)
//End if 