//%attributes = {}
// no queries must be done in this method. 
// the purpose is to copy the selection to the listbox


C_LONGINT:C283($i; $n)
READ ONLY:C145([eWires:13])

If (Form event code:C388=On Load:K2:1)
	ewr_initPOListBox
End if 

$n:=Records in selection:C76([eWires:13])

FIRST RECORD:C50([eWires:13])
ORDER BY:C49([eWires:13]; [eWires:13]eWireID:1)
listbox_deleteAllRows(->ewr_POListBox)

For ($i; 1; $n)
	listbox_appendRow(->ewr_POListBox)
	ewr_fillPOLisBoxRow($i)
	NEXT RECORD:C51([eWires:13])
End for 