//C_POINTER($tablePtr;$fieldPtr;$listBoxPtr)
//C_LONGINT($n)
//$tablePtr:=->[Customers]
//$fieldPtr:=->[Customers]CustomerID
//$listBoxPtr:=->lb_Customers
//
//$n:=Records in selection($tablePtr->)
//Case of 
//: ($n=0)
//REJECT
//: ($n>=1)
//vSearchText:=listbox_getSelectedRecordField ($listBoxPtr;$tablePtr;$fieldPtr)
//Else 
//End case 
//
C_LONGINT:C283(slb_Picker)
C_TEXT:C284(vSearchText)

handlePickButton(->[Customers:3]; ->[Customers:3]CustomerID:1; ->slb_Picker; ->vSearchText)