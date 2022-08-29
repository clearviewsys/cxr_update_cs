//%attributes = {}
// setTableID(->primaryKey;newID)
// ex: setTableID(->[eWires]eWireID; makeeWireID)

C_POINTER:C301($1)
C_TEXT:C284($2)


If ($1->="")
	$1->:=$2
End if 