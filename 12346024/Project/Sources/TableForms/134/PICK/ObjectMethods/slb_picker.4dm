C_POINTER:C301($searchTextPtr; $slb_PickerPtr)
$searchTextPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "vSearchText")
$slb_PickerPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "slb_picker")

handlePickFormListBox($slb_PickerPtr; $searchTextPtr; ->[List_Banks:134]; ->[List_Banks:134]BankName:3)
vSearchText:=$searchTextPtr->
POST OUTSIDE CALL:C329(Current process:C322)
