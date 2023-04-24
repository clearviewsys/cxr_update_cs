//%attributes = {}
// handleBranchDD
// handler from Branch DropDown menu in Accounts.ListBox
// PRE: On load and ON Clicked must be checked on the dropdown menu

#DECLARE($dropDownArray : Pointer; $bySelection : Integer)

C_TEXT:C284($branchID)

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222($dropDownArray->; 0)
End if 

handlePopupSelectRecordsByBrID($dropDownArray; ->[Invoices:5]; ->[Invoices:5]BranchID:53; $bySelection)
If ($dropDownArray->>1)
	$branchID:=$dropDownArray->{$dropDownArray->}
Else 
	$branchID:=""
End if 

If (Form event code:C388=On Clicked:K2:4)
	POST OUTSIDE CALL:C329(Current process:C322)
End if 