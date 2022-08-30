//%attributes = {}
If (Not:C34(isUserDesigner))
	checkAddError("This feature is restricted to designers only!")
End if 

checkIfNullString(->[FormObjects:120]Objectname:4; "Object Name")
