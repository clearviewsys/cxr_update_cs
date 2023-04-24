//%attributes = {}
// openNewAddressForm (-> table; ->RecordID; -> addresss; ->PostalCode; ->City; ->CountryCode)
C_OBJECT:C1216($obj; $status)

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($recordID; $2)
C_LONGINT:C283($win)

//#ORDA

Case of 
	: (Count parameters:C259=2)
		$obj:=ds:C1482.Addresses.new()
		
		$tablePtr:=$1
		$recordID:=$2
		
		$obj.RecordID:=$recordID
		$obj.TableNo:=Table:C252($tablePtr)
		$obj.Address:=""
		$obj.ZipCode:=""
		$obj.State:=""
		$obj.City:=""
		$obj.CountryCode:=""
		
		$win:=Open form window:C675([Addresses:147]; "new")
		DIALOG:C40([Addresses:147]; "new"; $obj)  // the object is passed to the form.
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



If (OK=1)
	$obj.AddressID:=makeAddressID
	
	$status:=$obj.save()
	
Else 
	// cancel has been pressed
End if 


