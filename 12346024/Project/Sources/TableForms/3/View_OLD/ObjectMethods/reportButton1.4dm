C_POINTER:C301($ptr; $tablePtr)
C_TEXT:C284($tableName)

$tablePtr:=->[CashTransactions:36]
$tableName:=Table name:C256($tablePtr)

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_Customers_"+$tableName)

tbar_report($ptr; $tablePtr)