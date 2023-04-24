//%attributes = {}
// queryRegistersbyCustomerGroup (groupName; fromDate;toDate;doApplyDateRange;{ignoreTransfers}; {ignoreLocalCurrency})
//POST: this will change the selection of records in the customer table

// this selection works based on the customer group itslef (not the invoice customer grouping)


C_TEXT:C284($groupName; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($applyDateRange; $4)
C_BOOLEAN:C305($doIgnoreTransfers; $5)
C_BOOLEAN:C305($doIgnoreLC; $6)
C_TEXT:C284($branchID; $7)

$doIgnoreTransfers:=False:C215
$doIgnoreLC:=False:C215
$branchID:=""

Case of 
	: (Count parameters:C259=4)
		$groupName:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		
	: (Count parameters:C259=5)
		$groupName:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		
	: (Count parameters:C259=6)
		$groupName:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		$doIgnoreLC:=$6
		
	: (Count parameters:C259=7)
		$groupName:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		$doIgnoreLC:=$6
		$branchID:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Customers:3])
READ ONLY:C145([Registers:10])

QUERY:C277([Customers:3]; [Customers:3]GroupName:90=$groupName)
// map those customers to the register table

RELATE MANY SELECTION:C340([Registers:10]CustomerID:5)  // select all registers that are linked to the selection in customers table

If ($branchID="")  // this if is handlling 4 cases BranchID x DateRange (00,01,10,11)
	
	If ($applyDateRange)  // all branches in date range
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
	Else 
		// all branches; all date ranges - already selected so nothing shall be done
	End if 
	
Else 
	
	If ($applyDateRange)  // branch ID is picked, and date range is picked
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID; *)  // composite index search
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
		QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
	Else   // only branch ID is picked wihtout date range 
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID)
	End if 
	
End if 

If ($doIgnoreTransfers)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
End if 

If ($doIgnoreLC)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
