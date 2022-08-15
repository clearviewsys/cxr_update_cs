//%attributes = {}
// handleSaveWireButton 
// this method is called from the save button for PAY/RECEIVE forms in [WireS]
checkInit
validateWires
validateAccountPickedInInvoice

C_TEXT:C284(vAML_POT; vAML_SOF)
vAML_POT:=""
vAML_SOF:=""

If (isValidationConfirmed)
	
	If (Is new record:C668([Wires:8]))
		[Wires:8]BranchID:47:=getBranchID
	Else 
		[Wires:8]modBranchID:68:=getBranchID
	End if 
	
	If (getClientAutoWirePrint)
		confirmPrintWire
	End if 
	// these global variables are meant to communicate these two fields back to the invoice
	vAML_POT:=[Wires:8]AML_PurposeOfTransaction:49
	vAML_SOF:=[Wires:8]AML_SourceOfFunds:66
	
	createRegisterofWires
	clearInvoiceEnterableVars
	
Else 
	REJECT:C38
End if 