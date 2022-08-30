//%attributes = {}
// queryRecordFromRows(->listbox;->table;->primaryKeyField; ->primarykeyArray)
// queryRecordFromRows (->lb; ->[registers];->[registers]registerID;->arrRegisterIDs)

// this will create a selection of records based on selected rows in the listbox
// the primary key must be an arrary 

C_POINTER:C301($listboxPtr; $1; $2; $3; $4; $tablePtr; $fieldPtr; $arrayPtr)
$listBoxPtr:=$1
$tablePtr:=$2
$fieldPtr:=$3
$arrayPtr:=$4

C_TEXT:C284($setName)
$setName:="$listboxSetTemp"

C_LONGINT:C283($n; $i)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
CREATE EMPTY SET:C140($tablePtr->; $setName)

For ($i; 1; $n)
	If ($listBoxPtr->{$i}=True:C214)
		QUERY:C277($tablePtr->; $fieldPtr->=$arrayPtr->{$i})
		ADD TO SET:C119($tablePtr->; $setName)
	End if 
End for 

USE SET:C118($setName)
CLEAR SET:C117($setName)
