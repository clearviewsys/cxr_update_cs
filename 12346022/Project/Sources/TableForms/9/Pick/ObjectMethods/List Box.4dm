//C_POINTER($1;$listBoxPtr)
//C_POINTER($tablePtr;$fieldPtr)
//$tablePtr:=->[Customers]
//$fieldPtr:=->[Customers]CustomerID
//
//If (Count parameters=1)
//$listBoxPtr:=$1
//Else 
//$listBoxPtr:=Focus object
//End if 
//  // 
//
//If ((Form event=On Clicked) | (Form event=On Selection Change) | (Form event=On Double Clicked))
//vSearchText:=listbox_getSelectedRecordField ($listBoxPtr;$tablePtr;$fieldPtr)
//End if 
//C_LONGINT(slb_picker)
C_TEXT:C284(vSearchText)
C_LONGINT:C283(SLB_PICKER)

handlePickFormListBox(->SLB_PICKER; ->vSearchText; ->[Accounts:9]; ->[Accounts:9]AccountID:1)
