
If (Form event code:C388=On Double Clicked:K2:5)
	handledoubleclickevent(->[Registers:10])
Else 
	//handleListboxColumnsSettings (->ListBoxRegistersGL;->[Registers];"GLReport";"ListBoxRegistersGL")
End if 

handleListBoxObjectMethod(->ListBoxRegistersGL; ->[Registers:10]; ->[Registers:10]CustomerID:5)
