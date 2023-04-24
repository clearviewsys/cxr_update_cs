//%attributes = {}

C_DATE:C307($date; $1; vFromDate; vToDate)
C_BOOLEAN:C305($isCancelled; $2)
C_TEXT:C284($branchID; vBranchID; $3)
$branchID:=""

Case of 
	: (Count parameters:C259=0)
		$date:=vFromDate
		$isCancelled:=False:C215
		$branchID:=vBranchID
		
	: (Count parameters:C259=1)
		$date:=$1
		$isCancelled:=False:C215
		$branchID:=vBranchID
	: (Count parameters:C259=2)
		$date:=$1
		$isCancelled:=$2
		$branchID:=vBranchID
		
	: (Count parameters:C259=3)
		$date:=$1
		$isCancelled:=$2
		$branchID:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($branchID="")
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=$date)
Else 
	// uses a compound index to search
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39=$branchID; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2=$date)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=$isCancelled)
