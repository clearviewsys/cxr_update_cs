//%attributes = {}
// setTableBranchDateTimeEtc(->table;->creationdateField;->creationtimeField;->modificationDateField;->modificationTimeField;->userID;->branchID)

C_POINTER:C301($tablePtr; $1)  // tablePtr
C_POINTER:C301($branchIDPtr; $2)  // branchID
C_POINTER:C301($createdDatePtr; $3)  // creation date
C_POINTER:C301($createdTimePtr; $4)  // creation time
C_POINTER:C301($createdByPtr; $5)  // creation user
C_POINTER:C301($modifiedDatePtr; $6)  // modification
C_POINTER:C301($modifiedTimePtr; $7)  // modification time
C_POINTER:C301($modifiedByPtr; $8)  // modification user
C_POINTER:C301($modBranchIDPtr; $9)  // modification branch

$tablePtr:=$1
$branchIDPtr:=$2


If (Is new record:C668($tablePtr->))
	$branchIDPtr->:=getBranchID
Else 
	If (Count parameters:C259>=9)
		$modBranchIDPtr:=$9
		$modBranchIDPtr->:=getBranchID
	End if 
End if 


Case of 
		
	: (Count parameters:C259=5)
		$createdDatePtr:=$3
		$createdTimePtr:=$4
		$createdByPtr:=$5
		
		If (Is new record:C668($tablePtr->))  // new record is created
			$createdDatePtr->:=Current date:C33
			$createdTimePtr->:=Current time:C178
			$createdByPtr->:=getApplicationUser
		End if 
		
	: (Count parameters:C259>=8)
		$createdDatePtr:=$3
		$createdTimePtr:=$4
		$createdByPtr:=$5
		$modifiedDatePtr:=$6  // modification
		$modifiedTimePtr:=$7  // modification time
		$modifiedByPtr:=$8  // modification user
		
		If (Is new record:C668($tablePtr->))  // new record is created
			$createdDatePtr->:=Current date:C33
			$createdTimePtr->:=Current time:C178
			$createdByPtr->:=getApplicationUser
		Else 
			$modifiedDatePtr->:=Current date:C33
			$modifiedTimePtr->:=Current time:C178
			$modifiedByPtr->:=getApplicationUser
		End if 
End case 

