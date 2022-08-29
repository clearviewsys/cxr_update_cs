C_POINTER:C301($ptr; $tablePtr)
C_TEXT:C284($tableName)

$tablePtr:=->[CashTransactions:36]
$tableName:=Table name:C256($tablePtr)

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_Customer_"+$tableName)
printListbox($ptr; qr printer:K14903:1)
