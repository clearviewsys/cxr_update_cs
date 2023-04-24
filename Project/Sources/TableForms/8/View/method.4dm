handleViewFormMethod(Current form table:C627)

RELATE ONE:C42([Wires:8]CustomerID:2)  // the set field relation doesn't work
RELATE ONE:C42([Wires:8]WireTemplateID:83)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([WireTemplates:42])
	//SET FIELD RELATION([Wires]CustomerID;Automatic;Manual)
	
	If (getKeyValue("currencyCloud.activated")="true")
		OBJECT SET VISIBLE:C603(*; "b_sendWire"; True:C214)
		OBJECT SET VISIBLE:C603(*; "h_currencyCloud"; True:C214)
		OBJECT SET VISIBLE:C603(*; "h_benID"; True:C214)
		OBJECT SET VISIBLE:C603(*; "h_payID"; True:C214)
		OBJECT SET VISIBLE:C603(*; "payID"; True:C214)
	End if 
End if 
If (getKeyValue("currencyCloud.activated")="true")
	If (Records in selection:C76([WireTemplates:42])>0)
		OBJECT SET VISIBLE:C603(*; "benID"; True:C214)
		OBJECT SET VISIBLE:C603(*; "wiresBenID"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "benID"; False:C215)
		OBJECT SET VISIBLE:C603(*; "wiresBenID"; True:C214)
	End if 
End if 

If ([Wires:8]isOutgoingWire:16)
	FORM GOTO PAGE:C247(2)
Else 
	FORM GOTO PAGE:C247(1)
End if 

If (Form event code:C388=On Unload:K2:2)
	//SET FIELD RELATION([Wires]CustomerID;Manual;Manual)
End if 