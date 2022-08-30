
C_POINTER:C301($ptrListbox)
C_LONGINT:C283($iTable)


$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")

$iTable:=iLB_Current_Table($ptrListbox)
GOTO SELECTED RECORD:C245(Table:C252($iTable)->; Selected record number:C246(Table:C252($iTable)->))
vPickRecNum:=Record number:C243(Table:C252($iTable)->)