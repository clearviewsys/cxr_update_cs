C_LONGINT:C283(CBQUERYSELECTION)

If (Form event code:C388=On Load:K2:1)
	//_O_ARRAY STRING(15;arrBranches;0)  // Modified by: Barclay Berry (7/26/13)
	ARRAY TEXT:C222(arrBranches; 0)
End if 


handlePopupSelectRecordsByBrID(->arrBranches; ->[Invoices:5]; ->[Invoices:5]BranchID:53; CBQUERYSELECTION)
If (arrBranches>1)
	vBranchID:=arrBranches{arrBranches}
	OBJECT SET VISIBLE:C603(*; "bAccounts@"; True:C214)
Else 
	vBranchID:=""
	OBJECT SET VISIBLE:C603(*; "bAccounts@"; False:C215)
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	POST OUTSIDE CALL:C329(Current process:C322)
End if 