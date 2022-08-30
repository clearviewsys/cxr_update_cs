//%attributes = {}
// FT_Get_EFTO_Transactions
// Gets all transactions from Register Table required to report according to the FINTRAC Requirements

// Define transaction arrays
C_DATE:C307($1; $fromDate; $2; $toDate)
C_BOOLEAN:C305($exported)
C_REAL:C285($thresholdForPTRTransfers)

ARRAY TEXT:C222($arrCustomers; 0)
ARRAY TEXT:C222($arrEwiresId; 0)

Case of 
	: (Count parameters:C259=0)
		$fromDate:=Add to date:C393(Current date:C33(*); 0; 0; -1)
		$toDate:=Current date:C33(*)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$fromDate:=Add to date:C393($1; 0; 0; -1)
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
	$thresholdForPTRTransfers:=10000
End if 

ARRAY BOOLEAN:C223(arr24HoursIndicator; 0)
ARRAY TEXT:C222($arrRecords; 0)

CREATE EMPTY SET:C140([eWires:13]; "efto")

C_TEXT:C284($queryType)
$queryType:=getKeyValue("FT.UseAMLRules"; "0")
Case of 
		
	: ($queryType="0")  // By Default: Do not use the AML Agr Rules
		
		FT_Set24HoursIndicatorEFTO($toDate; ->$arrRecords; ->arr24HoursIndicator)
		
	: ($queryType="1")  // By Default: Do not use the AML Agr Rules
		
		FT_Get_EwiresByRules($toDate; ->$arrRecords; ->arr24HourIndicator)
		QUERY SELECTION:C341([eWires:13]; [eWires:13]isPaymentSent:20=True:C214)
		
End case 



FIRST RECORD:C50([eWires:13])

If (reportingEntityLocationNumber#"ALL")
	QUERY SELECTION:C341([eWires:13]; [eWires:13]BranchID:50=reportBranchId)
End if 

SELECTION TO ARRAY:C260([eWires:13]eWireID:1; arrALLEFT)
CLEAR SET:C117("efto")

