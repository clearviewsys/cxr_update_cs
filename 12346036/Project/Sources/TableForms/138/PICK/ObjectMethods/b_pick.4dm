
C_POINTER:C301($searchTextPtr; $slb_PickerPtr)
$searchTextPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "vSearchText")
$slb_PickerPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "slb_picker")

handlePickButton(->[AML_RiskTemplates:138]; ->[AML_RiskTemplates:138]RiskTemplateID:2; $slb_PickerPtr; $searchTextPtr)
CLOSE WINDOW:C154(Frontmost window:C447)

