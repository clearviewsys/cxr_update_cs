C_POINTER:C301($searchTextPtr; $slb_PickerPtr)
$searchTextPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "vSearchText")
$slb_PickerPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "slb_picker")

handlePickFormListBox($slb_PickerPtr; $searchTextPtr; ->[AML_AggrRules:150]; ->[AML_AggrRules:150]ruleName:2)
vSearchText:=$searchTextPtr->
POST OUTSIDE CALL:C329(Current process:C322)
