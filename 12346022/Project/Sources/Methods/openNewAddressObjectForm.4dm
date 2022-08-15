//%attributes = {}
// openNewAddressObjectForm(C_OBJECT(): an address object to load in the form, and save the values into)
//returns boolean to indicate if object has been modified with some values
C_BOOLEAN:C305($0)
C_OBJECT:C1216($addressObject; $1)  //an object that represent an [Address] record
If (Count parameters:C259#1)
	assertInvalidNumberOfParams(Current method name:C684)
End if 
$addressObject:=$1
C_LONGINT:C283($win)

$win:=Open form window:C675([Addresses:147]; "Entry2")
DIALOG:C40([Addresses:147]; "Entry2"; $addressObject)  // the object is passed to the form.

If (OK=1)
	C_BOOLEAN:C305($areAllValuesEmpty)
	$areAllValuesEmpty:=($addressObject.Type="") & ($addressObject.State="") & ($addressObject.City="") & ($addressObject.ZipCode="") & ($addressObject.Address="") & ($addressObject.UnitNo="")  //&($addressObject.CountryCode="") couldn't test with removing country code
	If ($areAllValuesEmpty)  //make sure not every field is empty
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 
Else   // cancel has been pressed
	$0:=False:C215
End if 


