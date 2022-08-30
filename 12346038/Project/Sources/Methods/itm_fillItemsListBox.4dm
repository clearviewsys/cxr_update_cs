//%attributes = {}
C_LONGINT:C283($i; $n)

$n:=Records in selection:C76([Items:39])
FIRST RECORD:C50([Items:39])
ORDER BY:C49([Items:39]; [Items:39]ItemID:1; >)
listbox_deleteAllRows(->itm_ItemsListBox)
For ($i; 1; $n)
	listbox_appendRow(->itm_ItemsListBox)
	itm_fillItemsListBoxRow($i)
	NEXT RECORD:C51([Items:39])
End for 