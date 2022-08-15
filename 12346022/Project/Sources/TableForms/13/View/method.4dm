handleViewForm
If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Links:17])
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([Agents:22])
	READ ONLY:C145([Registers:10])
	
	SET FIELD RELATION:C919([eWires:13]LinkID:8; Automatic:K51:4; Manual:K51:3)
	SET FIELD RELATION:C919([eWires:13]CustomerID:15; Automatic:K51:4; Manual:K51:3)
	SET FIELD RELATION:C919([eWires:13]LinkID:8; Automatic:K51:4; Manual:K51:3)
End if 

If ((Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Load:K2:1))
	setVisibleIff((Picture size:C356([eWires:13]AttachedPicture:25)>0); "hasAttachment@")
	setVisibleIff([eWires:13]isSettled:23; "Settled@")
End if 

If (Form event code:C388=On Unload:K2:2)
	SET FIELD RELATION:C919([eWires:13]LinkID:8; Manual:K51:3; Manual:K51:3)
	SET FIELD RELATION:C919([eWires:13]CustomerID:15; Manual:K51:3; Manual:K51:3)
	SET FIELD RELATION:C919([eWires:13]LinkID:8; Manual:K51:3; Manual:K51:3)
End if 

