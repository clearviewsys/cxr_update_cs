//If (Form event code=On Clicked)
//Form.display.searchFields:=Form.searchFields=1
//C_POINTER($listboxPtr)
//$listboxPtr:=OBJECT Get pointer(Object named; "SanctionList")
//sl_handleSanctionListMatches($listboxPtr; Form.lists; Form.display; True)
//End if 
sl_handleFilterCheckBoxes("searchFields")
