//%attributes = {}
// queryRegistersForPL (curr)
// queryRegistersForPL (curr; branch)
// queryRegistersForPL (curr; branch; fromDate)
// queries registers up to a date but NOT INCLUDING that date

// POST: IMPORTANT: This query will omit all transfers and cancelled Registers
// POST: Registers will become read only
// POST: This method orders the registers by date and then by RegisterID
// Returns: numbers of records in selection


C_TEXT:C284($curr; $branchID; $1; $2)
C_DATE:C307($fromDate; $toDate; $3)
C_LONGINT:C283($n; $0)

$curr:=""
$fromDate:=!00-00-00!

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
		
	Else 
		ASSERT:C1129(False:C215; "invalid number of params")
End case 

READ ONLY:C145([Registers:10])

// search all registers from day 1 upto fromDate (not including that day

If ($fromDate=!00-00-00!)  // for optimization
	REDUCE SELECTION:C351([Registers:10]; 0)  // select none
Else 
	
	QUERY:C277([Registers:10]; [Registers:10]Currency:19=$curr)
	
	If ($branchID#"")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID)
	End if 
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<$fromDate)
	
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTrade:38=True:C214)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
	
	
	ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >; [Registers:10]RegisterID:1; >)
End if 

$n:=Records in selection:C76([Registers:10])
$0:=$n