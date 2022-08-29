//If (Form event code=On Clicked)
//$name:=makeFullName ([Customers]FirstName;[Customers]LastName)
//C_LONGINT($nameType)
//If ([Customers]isCompany)
//$nameType:=2
//Else
//$nameType:=1
//End if

//checkNameAgainstLists ($name;$nameType;True;->[Customers]CustomerID;"PEP";->latestCheckStatus1)

//If (getKeyValue("sanctionlist.version"; "v2")="v1")
//$name:=makeFullName([Customers]FirstName; [Customers]LastName)

//If (Length($name)>3)
//setErrorTrap("PEP Sanction List check failed")
//C_TEXT($result)
//C_LONGINT($match)
//$result:=checkNameAgainstList($name; ->$match; False; "PEP"; True)
//myAlert($result; sl_getSanctionListResultMsg($match))
//clearPictureField(->latestCheckStatus1)
//sl_setSanctionListCheckIcon($match; ->latestCheckStatus1)
//endErrorTrap
//End if
//Else
//C_TEXT($name; $recordID)
//C_LONGINT($tableId)
//C_POINTER($iconPtr; $onHoldPtr; $holdNotePtr)
//C_OBJECT($options)

//$name:=makeFullName([Customers]FirstName; [Customers]LastName)
//C_OBJECT($data)
//$data:=New object
//$data.pointers:=New object
//$data.options:=New object
//$data.pointers.resultIconPtr:=->latestCheckStatus1
//$data.options.manualList:="PEP"
//$data.options.autoList:="Customer"
//sl_handlePersonNameCompliance(True; $name; ->[Customers]CustomerID; $data)
sl_handleCustomerScreening(sl_CustomerPerson+sl_ForPEPButton)  //; $data)

//End if
//End if