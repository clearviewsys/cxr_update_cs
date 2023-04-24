//%attributes = {}
// select only the accounts that were active during a date range
C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($applyDateRange; $3)

$fromDate:=$1
$toDate:=$2

If (Count parameters:C259=3)
	$applyDateRange:=$3
Else 
	$applyDateRange:=False:C215
End if 

If ($applyDateRange)
	selectDateRangeTable(->[ItemInOuts:40]; ->[ItemInOuts:40]Date:3; $fromDate; $toDate)
Else 
	ALL RECORDS:C47([ItemInOuts:40])
End if 

RELATE ONE SELECTION:C349([ItemInOuts:40]; [Items:39])
orderByItems