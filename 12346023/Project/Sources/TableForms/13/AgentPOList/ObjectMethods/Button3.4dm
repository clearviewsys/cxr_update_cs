C_LONGINT:C283(vShowPrintedeWires)  // the checkbox

selecteWiresSentPendingByAccID(vAgentId; vAgentAccountID)

If (vShowPrintedeWires=0)
	QUERY SELECTION:C341([eWires:13]; [eWires:13]includedInAgentPO:49="")  // select only the ones that have not been printed already
End if 

orderByeWires
ewr_fillPOListBox