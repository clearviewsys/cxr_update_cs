C_LONGINT:C283(CBQUERYSELECTION)
C_TEXT:C284(vBranchID)

If (Form event code:C388=On Load:K2:1)
	//_O_ARRAY STRING(15;arrBranches;0)
	ARRAY TEXT:C222(arrBranches; 0)
End if 

handlePopupSelectRecordsByBrID(->arrBranches; ->[Invoices:5]; ->[Invoices:5]BranchID:53; CBQUERYSELECTION)
If (arrBranches>1)
	vBranchID:=arrBranches{arrBranches}
Else 
	vBranchID:=""
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (vBranchID#"")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=vBranchID)
	End if 
	//call process(current process)
	REDRAW:C174(mainListBox)
	
End if 