//%attributes = {}
// setApplicationUserForTable(->table;->createdByuserField;->modifiedByUserField; branchIDPtr; modifyByBranchPtr)
//use this method in entry form methods
//2/22/16 IBB added modBranchPtr

C_POINTER:C301($tablePtr; $fieldPtr; $createdByPtr; $modifiedByPtr; $branchPtr; $modBranchPtr; $1; $2; $3; $4; $5)
$tablePtr:=$1
$createdByPtr:=$2
$modifiedByPtr:=$3

C_TEXT:C284($branchTemp; $modbranchTemp)  //3/15/16


If (Count parameters:C259>=4)
	$branchPtr:=$4
Else 
	$branchPtr:=->$branchTemp
End if 

If (Count parameters:C259>=5)
	$modBranchPtr:=$5
Else 
	$modBranchPtr:=->$modbranchTemp
End if 

If (Form event code:C388=On Load:K2:1)
	If (Is new record:C668($tablePtr->))  // new record
		$createdByPtr->:=getApplicationUser
		$branchPtr->:=getBranchID
	Else   // modified
		$modifiedByPtr->:=getApplicationUser
		$modBranchPtr->:=getBranchID
	End if 
End if 
