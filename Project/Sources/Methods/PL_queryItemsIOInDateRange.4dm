//%attributes = {}
// queryItemInOutsFromDateToDate (inclusive both dates)
// queryItemInOutsForPL (itemID)
// queryItemInOutsForPL (itemID; branch)
// queryItemInOutsForPL (itemID; branch; fromDate)
// queryItemInOutsForPL (itemID; branch; fromDate; toDate)

// queries ItemInOuts up to a date but NOT INCLUDING that date

// POST: ItemInOuts will become read only
// POST: This method orders the ItemInOuts by date
// Returns: numbers of records in selection


C_TEXT:C284($itemID; $branchID; $1; $2)
C_DATE:C307($fromDate; $toDate; $3; $4)
C_LONGINT:C283($n; $0)

$itemID:=""
$fromDate:=!00-00-00!
$toDate:=Current date:C33

Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$itemID:=$1
		
	: (Count parameters:C259=2)
		$itemID:=$1
		$branchID:=$2
		
	: (Count parameters:C259=3)
		$itemID:=$1
		$branchID:=$2
		$fromDate:=$3
		
	: (Count parameters:C259=4)
		$itemID:=$1
		$branchID:=$2
		$fromDate:=$3
		$toDate:=$4
		
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

READ ONLY:C145([ItemInOuts:40])
ALL RECORDS:C47([ItemInOuts:40])
QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemID:2=$itemID)

If ($branchID#"")
	QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]BranchID:26=$branchID)
End if 

If ($fromDate#!00-00-00!)
	QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]Date:3>=$fromDate)
End if 

QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]Date:3<=$toDate)

ORDER BY:C49([ItemInOuts:40]; [ItemInOuts:40]Date:3; >)

$n:=Records in selection:C76([ItemInOuts:40])
$0:=$n