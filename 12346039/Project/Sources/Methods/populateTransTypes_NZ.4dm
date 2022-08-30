//%attributes = {}
// populateTransType_NZ

// populateCities_CA

// this will populate the Cities table with all cities of Canada
// ([Cities];"Listbox")

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_POINTER:C301($tablePtr; $keyPtr; $valuePtr)

$tablePtr:=->[TransactionTypes:93]
$keyPtr:=->[TransactionTypes:93]TransTypeID:1
$valuePtr:=->[TransactionTypes:93]Description:2

ALL RECORDS:C47($tablePtr->)

SELECTION TO ARRAY:C260($keyPtr->; $arrKeys; $valuePtr->; $arrValues)
populateTransTypesRows_NZ(->$arrKeys; ->$arrValues)
//execute method("populateTransTypesRows_NZ";->$arrKeys;->$arrValues)
ARRAY TO SELECTION:C261($arrKeys; $keyPtr->; $arrValues; $valuePtr->)

UNLOAD RECORD:C212($tablePtr->)
READ ONLY:C145($tablePtr->)