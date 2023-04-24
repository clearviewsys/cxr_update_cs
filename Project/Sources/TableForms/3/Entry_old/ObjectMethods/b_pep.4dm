If (Form event code:C388=On Clicked:K2:4)
	//$name:=makeFullName ([Customers]FirstName;[Customers]LastName)
	//C_LONGINT($nameType)
	//If ([Customers]isCompany)
	//$nameType:=2
	//Else
	//$nameType:=1
	//End if
	
	//checkNameAgainstLists ($name;$nameType;True;->[Customers]CustomerID;"PEP";->latestCheckStatus1)
	
	If (getKeyValue("sanctionlist.version"; "v2")="v1")
		$name:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
		
		If (Length:C16($name)>3)
			setErrorTrap("PEP Sanction List check failed")
			C_TEXT:C284($result)
			C_LONGINT:C283($match)
			$result:=checkNameAgainstList($name; ->$match; False:C215; "PEP"; True:C214)
			myAlert($result; sl_getSanctionListResultMsg($match))
			clearPictureField(->latestCheckStatus1)
			sl_setSanctionListCheckIcon($match; ->latestCheckStatus1)
			endErrorTrap
		End if 
	Else 
		C_TEXT:C284($name; $recordID)
		C_LONGINT:C283($tableId)
		C_POINTER:C301($iconPtr; $onHoldPtr; $holdNotePtr)
		C_OBJECT:C1216($options)
		
		$name:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
		//$tableId:=Table(->[Customers])
		//$recordID:=[Customers]CustomerID
		//$iconPtr:=->latestCheckStatus1
		//$onHoldPtr:=->[Customers]isOnHold
		//$holdNotePtr:=->[Customers]AML_OnHoldNotes
		//$options:=New object("setHold";New object(\
									"onHoldField";"onHold1";\
									"messageField";"reason_onHold"\
									))
		//handleCustomerNameCompliance(True;$name;->[Customers]CustomerID;->latestCheckStatus1;"PEP")
		
		C_OBJECT:C1216($data)
		$data:=New object:C1471
		$data.pointers:=New object:C1471
		$data.options:=New object:C1471
		$data.pointers.resultIconPtr:=->latestCheckStatus1
		$data.options.list:="PEP"
		slold_screenPerson(True:C214; $name; ->[Customers:3]CustomerID:1; $data)
		
		//checkNameAgainstPEP ($name;$tableId;$recordID;$iconPtr;$onHoldPtr;$holdNotePtr)
		//checkNameAgainstLists ($name;1;True;->[Customers]CustomerID;"PEP";->latestCheckStatus1;$options)
	End if 
End if 