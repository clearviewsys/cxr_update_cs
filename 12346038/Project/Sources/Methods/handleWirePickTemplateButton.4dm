//%attributes = {}

C_TEXT:C284($oldAccountID)
$oldAccountID:=[Wires:8]WireTemplateID:83
[Wires:8]WireTemplateID:83:=""

pickWireTemplateForCustomer(->[Wires:8]WireTemplateID:83; [Customers:3]CustomerID:1)
If (OK=1)
	mapWireTemplateToWire
Else 
	[Wires:8]WireTemplateID:83:=$oldAccountID  // restore the old value
End if 

