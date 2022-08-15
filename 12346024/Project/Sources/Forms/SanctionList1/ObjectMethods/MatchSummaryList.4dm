
//Case of
//: (Form event code=On Load)
//Form.selectedLists:=New collection
//: (Form event code=On Selection Change)
//Form.display.lists:=New collection

//C_OBJECT($list)
//For each ($list; Form.selectedLists)
//Form.display.lists.push($list.name)
//End for each

//C_POINTER($listboxPtr)
//$listboxPtr:=OBJECT Get pointer(Object named; "SanctionList")
//sl_handleSanctionListMatches($listboxPtr; Form.lists; Form.display; True)
//End case
sl_handleMatchSummaryList
