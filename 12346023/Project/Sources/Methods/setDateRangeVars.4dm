//%attributes = {}
// setDateRangeVars (fromDate;toDate;checkbox)
// setDateRangeVars (fromDate;toDate)

C_LONGINT:C283(cbApplyDateRange)
C_DATE:C307(vFromDate; vToDate; $1; $2)
C_BOOLEAN:C305($3)

Case of 
	: (Count parameters:C259=2)
		vFromDate:=$1
		vToDate:=$2
	: (Count parameters:C259=3)
		vFromDate:=$1
		vToDate:=$2
		cbApplyDateRange:=booleanToNum($3)
	Else 
		
End case 
