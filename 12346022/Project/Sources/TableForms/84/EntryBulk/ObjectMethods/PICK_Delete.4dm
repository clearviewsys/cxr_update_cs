
C_LONGINT:C283($iCol; $iRow)
C_POINTER:C301($ptrCodes; $ptrOrders; $ptrNames)

$ptrCodes:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Codes")
$ptrOrders:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Orders")
$ptrNames:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Names")


LISTBOX GET CELL POSITION:C971(BULK_Listbox; $iCol; $iRow)

DELETE FROM ARRAY:C228($ptrCodes->; $iRow)
DELETE FROM ARRAY:C228($ptrOrders->; $iRow)
DELETE FROM ARRAY:C228($ptrNames->; $iRow)