//PUSH RECORD([eWires])
//newRecord (->[Links];False;"EntryForCustomer")
//INPUT FORM([Links];$inputForm)
//  `MENU BAR(2)
PUSH RECORD:C176([eWires:13])
READ WRITE:C146([Links:17])
C_TEXT:C284($INPUTFORM)
C_LONGINT:C283($WinRef)

$inputForm:="entryForCustomer"
FORM SET INPUT:C55([Links:17]; $inputForm)
$WinRef:=Open form window:C675([Links:17]; $inputForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)
ADD RECORD:C56([Links:17]; *)

UNLOAD RECORD:C212([Links:17])
READ ONLY:C145([Links:17])

If (Ok=1)
	LOAD RECORD:C52([Links:17])
	appendToArray(->arrLinkIDs; ->[Links:17]LinkID:1)
	appendToArray(->arrLinkNames; ->[Links:17]FullName:4)
	appendToArray(->arrLinkCities; ->[Links:17]City:11)
	
	//SELECT LISTBOX ROW(lbLinkListBox;Get number of listbox rows(lbListBox);Replace listbox selection )
	//
	//QUERY([Links];[Links]LinkID=arrLinkIDs{getListBoxRowNumber (->lbLinkListBox)})
	//seteWireLinkInfoByLoadingLink 
	
	
	UNLOAD RECORD:C212([Links:17])  // commented this line in version 3.481
	
End if 

POP RECORD:C177([eWires:13])
//
//QUERY([Links];[Links]CustomerID=vCustomerID)
//ORDER BY([Links];[Links]LinkID;<)
//SELECTION TO ARRAY([Links]LinkID;arrLInkIDs;[Links]FullName;arrLinkNames;[Links]City;arrLinkCities)
//arrLInkIDs:=1
//arrLinkNames:=1
//arrLinkCities:=1