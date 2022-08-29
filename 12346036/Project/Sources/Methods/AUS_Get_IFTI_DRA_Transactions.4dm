//%attributes = {}

// AUS_Get_IFTI_DRA_Transactions
// Gets all transactions from Ewires Table required to report according to the AUSTRAC Instructions

// Define transaction arrays
C_DATE:C307($1; $fromDate; $2; $toDate)
C_BOOLEAN:C305($exported)
C_REAL:C285($thresholdForPTRTransfers)

ARRAY TEXT:C222($arrCustomers; 0)
ARRAY TEXT:C222($arrEwiresId; 0)

Case of 
	: (Count parameters:C259=0)
		$fromDate:=Current date:C33(*)
		$toDate:=Current date:C33(*)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$fromDate:=$1
		$toDate:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		
		$fromDate:=$1
		$toDate:=$2
		$exported:=False:C215
		
	: (Count parameters:C259=3)
		$fromDate:=$1
		$toDate:=$2
		$exported:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// Get The Cash Transactions >= $maxLimitRemittance in the data range

READ ONLY:C145([eWires:13])

If (<>thresholdForPTRTransfers>0)
	$thresholdForPTRTransfers:=<>thresholdForPTRTransfers
Else 
	$thresholdForPTRTransfers:=1000
End if 


AUS_QueryIFTO($fromDate; $toDate; True:C214)
CREATE SET:C116([eWires:13]; "$ifto")
AUS_QueryIFTI($fromDate; $toDate; True:C214)
CREATE SET:C116([eWires:13]; "$ifti")

UNION:C120("$ifto"; "$ifti"; "$ift")
USE SET:C118("$ift")
FIRST RECORD:C50([eWires:13])
While (Not:C34(End selection:C36([eWires:13])))
	APPEND TO ARRAY:C911(arrALLEFT; [eWires:13]eWireID:1)
	NEXT RECORD:C51([eWires:13])
End while 
CLEAR SET:C117("$ifto")
CLEAR SET:C117("$ifti")
CLEAR SET:C117("$ift")

orderByeWires

