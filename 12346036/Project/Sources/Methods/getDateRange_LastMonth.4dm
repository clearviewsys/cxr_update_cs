//%attributes = {}
// getDateRange_LastMonth (->fromDatePtr;->toDatePtr)
C_POINTER:C301($fromDatePtr; $toDatePtr; $1; $2)
C_DATE:C307($fromDate; $toDate; vFromDate; vToDate)

Case of 
	: (Count parameters:C259=0)
		$fromDatePtr:=->vFromDate
		$toDatePtr:=->vToDate
		
	: (Count parameters:C259=2)
		$fromDatePtr:=$1
		$toDatePtr:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$fromDate:=Add to date:C393(calcBOMonth; 0; -1; 0)  // deduct 1 month from Beginning of this month
$toDate:=Add to date:C393($fromDate; 0; 1; -1)  // add a month minus 1 day

$fromDatePtr->:=$fromDate
$toDatePtr->:=$toDate

