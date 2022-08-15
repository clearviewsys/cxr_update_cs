//%attributes = {}
// getDateRange_Today (->fromDatePtr;->toDatePtr)

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

$fromDate:=Current date:C33
$toDate:=Current date:C33

$fromDatePtr->:=$fromDate
$toDatePtr->:=$toDate