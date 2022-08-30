//%attributes = {}

// selectRegistersByCurrency (currency;fromDate;toDate;doApplyDateRange;{ignoreTransfers};{branchID})
// this method is data range savvy
C_TEXT:C284($currency; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($applyDateRange; $4)
C_BOOLEAN:C305($doIgnoreTransfers; $5)
C_TEXT:C284($branchID; $6)

Case of 
	: (Count parameters:C259=4)
		$currency:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=False:C215
		
	: (Count parameters:C259=5)
		$currency:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		
	: (Count parameters:C259=6)
		$currency:=$1
		$fromDate:=$2
		$toDate:=$3
		$applyDateRange:=$4
		$doIgnoreTransfers:=$5
		$branchID:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

QUERY:C277([Registers:10]; [Registers:10]Currency:19=$currency)

If ($branchID#"")
	QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branchID)
End if 

If ($applyDateRange)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=$fromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
End if 

If ($doIgnoreTransfers)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)

