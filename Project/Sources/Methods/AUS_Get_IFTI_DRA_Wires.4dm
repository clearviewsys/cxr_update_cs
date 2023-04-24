//%attributes = {}

// AUS_Get_IFTI_DRA_Wires
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

CREATE EMPTY SET:C140([Wires:8]; "eft")
AUS_QueryIFTO_Wires($fromDate; $toDate; True:C214)
USE SET:C118("eft")

FIRST RECORD:C50([Wires:8])
SELECTION TO ARRAY:C260([Wires:8]WireNo:48; arrALLEFT)

CLEAR SET:C117("eift")

orderByeWires

