
C_TEXT:C284($result)
C_LONGINT:C283($match)

If (Length:C16([Customers:3]CompanyName:42)>3)
	
	//If (getKeyValue ("sanctionlist.version";"v2")="v1")
	slold_screenCompany(True:C214)
	//Else
	//C_TEXT($name;$recordId)
	//C_LONGINT($tableId)
	//C_POINTER($iconPtr;$onHoldPtr;$holdNotePtr)
	
	//$name:=[Customers]CompanyName
	//$tableId:=Table(->[Customers])
	//$recordId:=[Customers]CustomerID
	//$iconPtr:=->latestCheckStatus2
	//$onHoldPtr:=->[Customers]isOnHold
	//$holdNotePtr:=->[Customers]AML_OnHoldNotes
	//checkNameAgainstEnabledSanction ($name;$tableId;$recordId;$iconPtr;$onHoldPtr;$holdNotePtr;True)
	//End if
End if 