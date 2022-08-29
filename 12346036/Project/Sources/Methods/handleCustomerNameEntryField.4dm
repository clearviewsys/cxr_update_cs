//%attributes = {}
// handleCustomerNameEntryField (->fieldPtr)
// call this method inside [customers]firstName or lastName field object on the form

// Edited by: Wai-Kin

C_POINTER:C301($fieldPtr; $1)
$fieldPtr:=$1
$fieldPtr->:=removeEnclosingSpaces(toTitleCase($fieldPtr))
sl_handleCustomerScreening(sl_CustomerPerson+sl_ForInputBox)

//checkCustomerFullName

//If (([Customers]FirstName#"") & ([Customers]LastName#""))
//If (getKeyValue ("sanctionlist.version";"v2")="v1")
//checkCustomerFullName
//Else
//C_TEXT($fullName)
//$fullName:=makeFullName ([Customers]FirstName;[Customers]LastName)
//C_LONGINT($tableNum)
//$tableNum:=Table(->[Customers])
//$recordId:=[Customers]CustomerID
//C_POINTER($iconPtr;$onHoldPtr;$holdNotePtr)
//$iconPtr:=->latestCheckStatus1
//$onHoldPtr:=->[Customers]isOnHold
//$holdNotePtr:=->[Customers]AML_OnHoldNotes
//$options:=New object("setHold";New object(\
						"onHoldField";"onHold1";\
						"messageField";"reason_onHold"\
						))
//automateSanctionChecks ($fullName;$tableNum;$recordId;$iconPtr;$onHoldPtr;$holdNotePtr)
//  //checkNameAgainstLists ($fullName;1;False;->[Customers]CustomerID;"";->latestCheckStatus1;$options)

//End if

//C_TEXT($fullName)
//$fullName:=makeFullName([Customers]FirstName; [Customers]LastName)
//handleCustomerNameCompliance (False;$fullName)
//sl_handlePersonNameCompliance(False; $fullName; ->[Customers]CustomerID)
//New object(\
						"options"; New object("useWorker"; True)\
				))
//End if