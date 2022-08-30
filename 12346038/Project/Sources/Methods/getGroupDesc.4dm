//%attributes = {}
// getGroupDesc
// Get the Group description for FINTRAC

C_TEXT:C284($0; $1; $branchId)

Case of 
		
	: (Count parameters:C259=1)
		$branchId:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ ONLY:C145([Branches:70])
QUERY:C277([Branches:70]; [Branches:70]BranchID:1=$branchId)

If (Records in selection:C76([Branches:70])>0)
	$0:=[Branches:70]BranchName:2
Else 
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getKeyValue("FT.MainBranchCode"; "HO"))
	
	If ([Branches:70]BranchName:2#"")
		$0:=[Branches:70]BranchName:2
	Else 
		$0:=getKeyValue("FT.MainBranchName"; " ")
	End if 
	
End if 




