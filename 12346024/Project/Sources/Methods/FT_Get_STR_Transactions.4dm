//%attributes = {}
// FT_Get_STR_Transactions
// Gets all transactions from Register Table required to report according to the FINTRAC Requirements

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

READ ONLY:C145([AML_Reports:119])
QUERY:C277([AML_Reports:119]; [AML_Reports:119]DecisionDate:17>=$fromDate; *)
QUERY:C277([AML_Reports:119];  & ; [AML_Reports:119]DecisionDate:17<=$toDate; *)
QUERY:C277([AML_Reports:119];  & ; [AML_Reports:119]isSuspiciousActivity:21=True:C214; *)
QUERY:C277([AML_Reports:119];  & ; [AML_Reports:119]Decision:18=1)




FIRST RECORD:C50([AML_Reports:119])


While (Not:C34(End selection:C36([AML_Reports:119])))
	APPEND TO ARRAY:C911(arrALLEFT; [AML_Reports:119]AML_ReportID:14)
	NEXT RECORD:C51([AML_Reports:119])
End while 

orderByAML_Reports

