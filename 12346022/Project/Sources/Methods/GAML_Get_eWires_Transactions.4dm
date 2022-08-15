//%attributes = {}
// GAML_Get_eWires_Transactions
// Gets all transactions from Register Table required to report according to the Remittance goAML Requirements

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


GAML_GetIFTO_Ewires($fromDate; $toDate; True:C214; $thresholdForPTRTransfers)
CREATE SET:C116([eWires:13]; "$ifto")
GAML_GetIFTI_Ewires($fromDate; $toDate; True:C214; $thresholdForPTRTransfers)
CREATE SET:C116([eWires:13]; "$ifti")

UNION:C120("$ifto"; "$ifti"; "$ift")
USE SET:C118("$ift")
FIRST RECORD:C50([eWires:13])


CLEAR VARIABLE:C89(arrALLEFT)
SELECTION TO ARRAY:C260([eWires:13]eWireID:1; arrALLEFT)

CLEAR SET:C117("$ifto")
CLEAR SET:C117("$ifti")
CLEAR SET:C117("$ift")

orderByeWires


