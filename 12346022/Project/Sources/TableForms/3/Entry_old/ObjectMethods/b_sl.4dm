If (Form event code:C388=On Clicked:K2:4)
	//If (getKeyValue ("sanctionlist.version";"v2")="v1")
	//handleCustomerNameCompliance (True)
	slold_screenPerson(True:C214)
	//Else
	//C_TEXT($name;$recordId)
	//C_LONGINT($tableId)
	//C_POINTER($iconPtr;$onHoldPtr;$holdNotePtr)
	
	//$name:=makeFullName ([Customers]FirstName;[Customers]LastName)
	//$tableId:=Table(->[Customers])
	//$recordId:=[Customers]CustomerID
	//$iconPtr:=->latestCheckStatus1
	//$onHoldPtr:=->[Customers]isOnHold
	//$holdNotePtr:=->[Customers]AML_OnHoldNotes
	//checkNameAgainstEnabledSanction ($name;$tableId;$recordId;$iconPtr;$onHoldPtr;$holdNotePtr)
	
	//$options:=New object("setHold";New object("onHoldField";"onHold1";"messageField";"reason_onHold"))
	
	//checkNameAgainstLists ($name;1;True;->[Customers]CustomerID;"";->latestCheckStatus1;$options)
	//End if
End if 