//%attributes = {}
// handlePopUpSelectRecordsByBrID (->self;->[table];->branchIDField;inSelection: int)
// Select records 

C_POINTER:C301($objectPtr; $1)
C_POINTER:C301($tablePtr; $2)
C_POINTER:C301($branchFieldPtr; $3)
C_LONGINT:C283($inSelection; $4)

$objectPtr:=$1
$tablePtr:=$2
$branchFieldPtr:=$3
$inSelection:=$4

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145($tablePtr->)  // to prevent locking
	READ ONLY:C145([Branches:70])
	allRecordsBranches
	SELECTION TO ARRAY:C260([Branches:70]BranchID:1; $objectPtr->)
	INSERT IN ARRAY:C227($objectPtr->; 1)
	$objectPtr->{1}:="Branch"
	$objectPtr->:=1
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($branch)
	
	If ($objectPtr->>1)
		$branch:=$objectPtr->{$objectPtr->}
		
		If ($inSelection=1)
			// if 'filter within selection' is on
			QUERY SELECTION:C341($tablePtr->; $branchFieldPtr->=$branch)
		Else 
			QUERY:C277($tablePtr->; $branchFieldPtr->=$branch)
		End if 
		orderByBranches
	End if 
End if 

