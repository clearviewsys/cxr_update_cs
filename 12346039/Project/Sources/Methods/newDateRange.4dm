//%attributes = {}
// newDateRange (fromDate; toDate; apply): object
// class DateRange {
//    fromDate: Date; 
//    toDate: Date; 
//    applyDateRange: boolean
//  }


C_DATE:C307($1; $2; $fromDate; $toDate)
C_BOOLEAN:C305($3; $applyDateRange)
C_OBJECT:C1216($0; $dateRangeObj)

Case of 
	: (Count parameters:C259=0)
		$fromDate:=Current date:C33
		$toDate:=Current date:C33
		$applyDateRange:=True:C214
		
	: (Count parameters:C259=1)
		$fromDate:=$1
		$toDate:=$1
		$applyDateRange:=True:C214
		
	: (Count parameters:C259=2)
		$fromDate:=$1
		$toDate:=$2
		$applyDateRange:=True:C214
		
	: (Count parameters:C259=3)
		$fromDate:=$1
		$toDate:=$2
		$applyDateRange:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$dateRangeObj:=New object:C1471
$dateRangeObj.fromDate:=$fromDate
$dateRangeObj.toDate:=$toDate
$dateRangeObj.applyDateRange:=$applyDateRange

$0:=$dateRangeObj