//%attributes = {}
// queryRegistersInDateRange( fromDate;toDate;isCancelled)

C_DATE:C307($fromDate; $toDate; $1; $2; vFromDate; vToDate)
C_BOOLEAN:C305($isCancelled; $3)

Case of 
	: (Count parameters:C259=0)
		$fromDate:=vFromDate
		$toDate:=vToDate
		$isCancelled:=False:C215
	: (Count parameters:C259=2)
		$fromDate:=$1
		$toDate:=$2
	: (Count parameters:C259=3)
		$fromDate:=$1
		$toDate:=$2
		$isCancelled:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Registers:10])
SET QUERY DESTINATION:C396(Into current selection:K19:1)

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=$isCancelled)
