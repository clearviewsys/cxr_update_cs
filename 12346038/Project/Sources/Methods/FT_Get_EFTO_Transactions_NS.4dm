//%attributes = {}
// FT_Get_EFTO_Transactions_NS
// Gets all transactions from Register Table required to report according to the FINTRAC Requirements

// Define transaction arrays
C_DATE:C307($1; $fromDate; $2; $toDate)

C_REAL:C285($thresholdForPTRTransfers)

ARRAY TEXT:C222($arrCustomers; 0)
ARRAY TEXT:C222($arrEwiresId; 0)

Case of 
	: (Count parameters:C259=0)
		
		$fromDate:=Add to date:C393(Current date:C33(*); 0; 0; -1)
		$toDate:=Current date:C33(*)
		
	: (Count parameters:C259=1)
		
		$fromDate:=Add to date:C393($1; 0; 0; -1)
		$toDate:=$1
		
	: (Count parameters:C259=2)
		
		$fromDate:=$1
		$toDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// Get The Cash Transactions >= $maxLimitRemittance in the data range

READ ONLY:C145([Wires:8])

If (<>thresholdForPTRTransfers>0)
	$thresholdForPTRTransfers:=<>thresholdForPTRTransfers
Else 
	$thresholdForPTRTransfers:=10000
End if 

ARRAY BOOLEAN:C223(arr24HoursIndicator; 0)
ARRAY TEXT:C222($arrRecords; 0)

CREATE EMPTY SET:C140([Wires:8]; "eft")

C_TEXT:C284($queryType)

$queryType:=getKeyValue("FT.UseAMLRules"; "0")
Case of 
		
	: ($queryType="0")  // By Default: Do not use the AML Agr Rules
		
		
		FT_Set24HoursIndicatorEFT_NS($toDate; ->$arrRecords; ->arr24HoursIndicator; reportBranchId; True:C214)
		
		
	: ($queryType="1")  // By Default: Do not use the AML Agr Rules
		
		FT_Get_WiresByRules_NS($toDate; ->$arrRecords; ->arr24HoursIndicator)
		QUERY SELECTION:C341([Wires:8]; [Wires:8]isOutgoingWire:16=True:C214)
		
End case 



FIRST RECORD:C50([Wires:8])

If (reportingEntityLocationNumber#"ALL")
	QUERY SELECTION:C341([Wires:8]; [Wires:8]BranchID:47=reportBranchId)
End if 

SELECTION TO ARRAY:C260([Wires:8]CXR_WireID:1; arrALLEFT)
CLEAR SET:C117("eft")

