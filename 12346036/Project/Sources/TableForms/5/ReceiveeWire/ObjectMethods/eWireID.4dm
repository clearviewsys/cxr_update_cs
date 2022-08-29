C_LONGINT:C283($counteWires)
C_TEXT:C284(vCustomerID)
pickeWireForCustomer(Self:C308; vCustomerID)
If (veWireID#"")
	RELATE ONE:C42([eWires:13]LinkID:8)
Else 
	UNLOAD RECORD:C212([eWires:13])
	UNLOAD RECORD:C212([Links:17])
End if 