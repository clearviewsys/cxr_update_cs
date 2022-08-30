//%attributes = {}
C_TEXT:C284($0)

READ ONLY:C145([Branches:70])
QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getClientBranchID)  // select this branch
If (Records in selection:C76([Branches:70])=1)
	$0:=([Branches:70]BranchPhone:5)
Else 
	$0:=(<>COMPANYTEL1)
	
End if 