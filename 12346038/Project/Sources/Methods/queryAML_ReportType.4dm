//%attributes = {}
// queryAML_ReportType (queryType)

C_TEXT:C284($reportType; $1)

Case of 
	: (Count parameters:C259=0)
		$reportType:="SAR"
	: (Count parameters:C259=1)
		$reportType:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([AML_Reports:119])
QUERY:C277([AML_Reports:119]; [AML_Reports:119]TypeofReport:5=$reportType)
orderByAML_Reports