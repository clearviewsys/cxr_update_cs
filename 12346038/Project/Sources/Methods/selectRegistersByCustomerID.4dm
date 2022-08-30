//%attributes = {}

// selectRegisterByCustomerID (customerID;fromDate;toDate;doApplyDateRange;{ignoreTransfers}; ignoreLC; branchID)

C_TEXT:C284($customerID; $1)
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
		$customerID:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		
	: (Count parameters:C259=5)
		$customerID:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		
	: (Count parameters:C259=6)
		$customerID:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		$doIgnoreLC:=$6
		
	: (Count parameters:C259=7)
		$customerID:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		$doIgnoreLC:=$6
		$branchID:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



READ ONLY:C145([Registers:10])

If ($branchID#"")
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39=$branchID)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=$customerID)
Else 
	QUERY:C277([Registers:10]; [Registers:10]CustomerID:5=$customerID)
End if 


If ($applyDateRange)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)

If ($doIgnoreTransfers)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
End if 

If ($doIgnoreLC)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY)
End if 