//%attributes = {}
// testModule (->table)

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($tableName; $methodName)

$tablePtr:=->[Customers:3]
$tableName:=Table name:C256($tablePtr)


$methodName:="newRecord"+$tableName
executeMethodWTrap($methodName)

//$methodName:="orderBy"+$tableName
//executeMethodWTrap ($methodName)
//
//  // allRecordsTable
//$methodName:="allRecords"+$tableName
//executeMethodWTrap ($methodName)

// printTable
$methodName:="print"+$tableName
executeMethodWTrap($methodName)

// displayListTable
$methodName:="displayList"+$tableName
executeMethodWTrap($methodName)

//  // searchTable
//$methodName:="search"+$tableName
//executeMethodWTrap ($methodName)
//
// validateTable
$methodName:="validate"+$tableName
executeMethodWTrap($methodName)

// deleteTable
$methodName:="delete"+$tableName
executeMethodWTrap($methodName)

//showFlagged
$methodName:="showFlagged"+$tableName
executeMethodWTrap($methodName)

//  //showTodays
//$methodName:="showTodays"+$tableName
//executeMethodWTrap ($methodName)

// toggleFlaggedTable
$methodName:="toggleFlagged"+$tableName
executeMethodWTrap($methodName)

// showRelevant
$methodName:="showRelevant"+$tableName
executeMethodWTrap

