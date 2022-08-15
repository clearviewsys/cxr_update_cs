C_LONGINT:C283(CBQUERYSELECTION)
C_TEXT:C284(vBranchID)


If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrBranches; 0)
End if 

handlePopupSelectRecordsByBrID(->arrBranches; ->[Invoices:5]; ->[Invoices:5]BranchID:53; CBQUERYSELECTION)
If (arrBranches>1)
	vBranchID:=arrBranches{arrBranches}
Else 
	vBranchID:=""
End if 

If (Form event code:C388=On Clicked:K2:4)
	//CALL PROCESS(Current process)
End if 