//%attributes = {}
// queryRegistersFromDateToDate (inclusive both dates)
// this method is optimized for the P&L 

// queryRegistersForPL (curr)
// queryRegistersForPL (curr; branch)
// queryRegistersForPL (curr; branch; fromDate)
// queryRegistersForPL (curr; branch; fromDate; toDate)

// queries registers up to a date but NOT INCLUDING that date

// POST: IMPORTANT: This query will omit all transfers and cancelled Registers
// POST: Registers will become read only
// POST: This method orders the registers by date and then by RegisterID
// Returns: numbers of records in selection


C_TEXT:C284($curr; $branchID; $1; $2)
C_DATE:C307($fromDate; $toDate; $3; $4)
C_LONGINT:C283($n; $0)

$curr:=""
$fromDate:=!00-00-00!
$toDate:=Current date:C33

Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$curr:=$1
		
	: (Count parameters:C259=2)
		$curr:=$1
		$branchID:=$2
		
	: (Count parameters:C259=3)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
		
	: (Count parameters:C259=4)
		$curr:=$1
		$branchID:=$2
		$fromDate:=$3
		$toDate:=$4
		
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

READ ONLY:C145([Registers:10])

QUERY:C277([Registers:10]; [Registers:10]Currency:19=$curr)

If ($branchID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID)
End if 

If ($fromDate#!00-00-00!)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=$toDate)

//QUERY SELECTION([Registers];[Registers]isTrade=True)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)


ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >; [Registers:10]RegisterID:1; >)

$n:=Records in selection:C76([Registers:10])
$0:=$n