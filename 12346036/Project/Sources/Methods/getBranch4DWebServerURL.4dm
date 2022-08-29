//%attributes = {}
C_TEXT:C284($0; $branchID)
$branchID:=$1

READ ONLY:C145([Branches:70])
QUERY:C277([Branches:70]; [Branches:70]BranchID:1=$branchID)  // select this branch
If (Records in selection:C76([Branches:70])=1)
	$0:=[Branches:70]WebServerURL:9
Else 
	$0:="localhost:8080"
End if 