handleViewFormMethod(Current form table:C627)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([WireTemplates:42])
	//SET FIELD RELATION([Wires]CustomerID;Automatic;Manual)
	
End if 
RELATE ONE:C42([Wires:8]CustomerID:2)  // the set field relation doesn't work

If ([Wires:8]isOutgoingWire:16)
	FORM GOTO PAGE:C247(2)
Else 
	FORM GOTO PAGE:C247(1)
End if 

If (Form event code:C388=On Unload:K2:2)
	//SET FIELD RELATION([Wires]CustomerID;Manual;Manual)
End if 