//%attributes = {}
C_POINTER:C301($listboxPtr; $1)
$listBoxPtr:=$1

C_LONGINT:C283(vTotalRows)
vTotalRows:=LISTBOX Get number of rows:C915($listBoxPtr->)
