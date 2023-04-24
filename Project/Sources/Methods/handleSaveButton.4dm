//%attributes = {}
// handleSaveButton (->[table];->branchID;->createdDateField;->createdTimeField;->createdBy;->modifiyDateField;->modifyTimeField;->modifedBy;)
// handleSaveButton

C_POINTER:C301($tablePtr; $1)  // tablePtr
C_POINTER:C301($branchIDPtr; $2)  // branchID
C_POINTER:C301($createdDatePtr; $3)  // creation date
C_POINTER:C301($createdTimePtr; $4)  // creation time
C_POINTER:C301($createdByPtr; $5)  // creation user
C_POINTER:C301($modifiedDatePtr; $6)  // modification
C_POINTER:C301($modifiedTimePtr; $7)  // modification time
C_POINTER:C301($modifiedByPtr; $8)  // modification user
C_POINTER:C301($modBranchIDPtr; $9)  //modification branch
C_BOOLEAN:C305($ignoreFieldConstraints; $10)  // ignore field constraints (e.g. for Customer.isAccount=true)

C_POINTER:C301($modifedDatePtr; $modifedTimePtr)

$ignoreFieldConstraints:=False:C215

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
		
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$branchIDPtr:=$2
		setTableBranchDateTimeEtc($tablePtr; $branchIDPtr)
		
	: (Count parameters:C259=5)
		$tablePtr:=$1
		$branchIDPtr:=$2
		$createdDatePtr:=$3
		$createdTimePtr:=$4
		$createdByPtr:=$5
		
		setTableBranchDateTimeEtc($tablePtr; $branchIDPtr; $createdDatePtr; $createdTimePtr; $createdByPtr)
		
	: (Count parameters:C259=8)
		$tablePtr:=$1
		$branchIDPtr:=$2
		$createdDatePtr:=$3
		$createdTimePtr:=$4
		$createdByPtr:=$5
		$modifiedDatePtr:=$6  // modification
		$modifiedTimePtr:=$7  // modification time
		$modifiedByPtr:=$8  // modification user
		
		setTableBranchDateTimeEtc($tablePtr; $branchIDPtr; $createdDatePtr; $createdTimePtr; $createdByPtr; $modifiedDatePtr; $modifiedTimePtr; $modifiedByPtr)
		
	: (Count parameters:C259=9)
		
		$tablePtr:=$1
		$branchIDPtr:=$2
		$createdDatePtr:=$3
		$createdTimePtr:=$4
		$createdByPtr:=$5
		$modifiedDatePtr:=$6  // modification
		$modifiedTimePtr:=$7  // modification time
		$modifiedByPtr:=$8  // modification user
		$modBranchIDPtr:=$9
		
		setTableBranchDateTimeEtc($tablePtr; $branchIDPtr; $createdDatePtr; $createdTimePtr; $createdByPtr; $modifiedDatePtr; $modifiedTimePtr; $modifiedByPtr; $modBranchIDPtr)
		
	: (Count parameters:C259=10)
		
		$tablePtr:=$1
		$branchIDPtr:=$2
		$createdDatePtr:=$3
		$createdTimePtr:=$4
		$createdByPtr:=$5
		$modifiedDatePtr:=$6  // modification
		$modifiedTimePtr:=$7  // modification time
		$modifiedByPtr:=$8  // modification user
		$modBranchIDPtr:=$9
		$ignoreFieldConstraints:=$10
		
		setTableBranchDateTimeEtc($tablePtr; $branchIDPtr; $createdDatePtr; $createdTimePtr; $createdByPtr; $modifiedDatePtr; $modifiedTimePtr; $modifiedByPtr; $modBranchIDPtr)
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// validation for the table is done at this level
validateFieldsForTable($tablePtr; $ignoreFieldConstraints)
