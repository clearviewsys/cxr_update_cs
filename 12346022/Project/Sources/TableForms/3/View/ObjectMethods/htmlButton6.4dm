C_POINTER:C301($ptr; $tablePtr)
C_TEXT:C284($tableName)

$tablePtr:=->[Registers:10]
$tableName:=Table name:C256($tablePtr)

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LB_Customers_"+$tableName)
printListbox($ptr; qr HTML file:K14903:5)