//%attributes = {}
If (Form event code:C388=On Printing Detail:K2:18)
	RELATE ONE:C42([eWires:13]LinkID:8)
	RELATE ONE:C42([eWires:13]CustomerID:15)
	hideObjectsOnTrue([Links:17]CustomerID:14=[eWires:13]CustomerID:15; "CustomerError")
End if 