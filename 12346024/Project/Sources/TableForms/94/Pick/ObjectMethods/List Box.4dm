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
C_LONGINT:C283(slb_picker)
C_TEXT:C284(vSearchText)

handlePickFormListBox(->slb_picker; ->vSearchText; ->[CustomerTypes:94]; ->[CustomerTypes:94]CustomerTypeID:1)
POST OUTSIDE CALL:C329(Current process:C322)
