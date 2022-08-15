//%attributes = {"publishedWeb":true}
// createSerializedID (»Table;Startingpoint;branchID)-> text

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283($2; $startSeq)
C_TEXT:C284($3; $branchID)

C_TEXT:C284($0)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
		$startSeq:=10000
		$branchID:=getBranchID
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$startSeq:=$2
		$branchID:=getBranchID
		
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$startSeq:=$2
		$branchID:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=$branchID+Uppercase:C13(Substring:C12(Table name:C256($tablePtr); 1; 3))+String:C10(Sequence number:C244($tablePtr->)+$startSeq)