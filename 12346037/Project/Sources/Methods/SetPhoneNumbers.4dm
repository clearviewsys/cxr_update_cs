//%attributes = {}
// SetPhoneNumbers ($node)

C_TEXT:C284($node)

Case of 
	: (Count parameters:C259=1)
		$node:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($tmp)
$tmp:=""

If ([Customers:3]HomeTel:6#"")
	GAML_SetPhones($node; ->$tmp; ->$tmp; ->[Customers:3]HomeTel:6)  // It is a Company Use the WorkPhone Number
Else 
	If ([Customers:3]CellPhone:13#"")
		GAML_SetPhones($node; ->$tmp; ->$tmp; ->[Customers:3]CellPhone:13)  // It is a Company Use the WorkPhone Number
	Else 
		If ([Customers:3]WorkTel:12#"")
			GAML_SetPhones($node; ->$tmp; ->$tmp; ->[Customers:3]WorkTel:12)  // It is a Company Use the WorkPhone Number
		End if 
	End if 
End if 

