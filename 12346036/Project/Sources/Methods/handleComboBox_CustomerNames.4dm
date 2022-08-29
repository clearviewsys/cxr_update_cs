//%attributes = {}
//handleComboBoxCustomerNames (self; ->[customers]companyName; ->[customers]companyID)
C_POINTER:C301($self)
C_POINTER:C301($companyNameFieldPtr; $companyIDFieldPtr)

Case of 
	: (Count parameters:C259=0)
		$self:=Self:C308
		$companyIDFieldPtr:=->[Customers:3]CompanyID:141
		$companyNameFieldPtr:=->[Customers:3]CompanyName:42
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_COLLECTION:C1488($coll)
C_OBJECT:C1216($es)

C_TEXT:C284($companyID; $companyName)

If (Form event code:C388=On Load:K2:1)
	// #ORDA
	$coll:=ds:C1482.Customers.query("isCompany = true").orderBy("FullName").toCollection("FullName")  // or any other query goes here
	If ($coll.length>0)
		COLLECTION TO ARRAY:C1562($coll; $self->; "FullName")
	End if 
	If ($companyNameFieldPtr->#"")  // if there is a current value
		$self->{0}:=$companyNameFieldPtr->  // set the default value
	End if 
End if 

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	$companyName:=$self->{$self->}  //
	$es:=ds:C1482.Customers.query("FullName = :1"; $companyName)  // search for the companyName
	If ($es.length>0)
		$companyID:=$es[0].CustomerID  // if the companyName already exist in the database
	Else   // this is a new company
		$companyID:=""
		$companyNameFieldPtr->:=$companyName  // mutate the companyName field to become the new entered value of the combobox
		
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
	$companyIDFieldPtr->:=$companyID
	
End if 