//%attributes = {}
// getThisBranchAddress -> address
// returns the branch address of this computer or just returns the company address if it cannot find a profile


C_TEXT:C284($0; $address)
selectClientPrefsRecord

If (Records in selection:C76([ClientPrefs:26])=1)
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getBranchID)
	If ((Records in selection:C76([Branches:70])=1) & ([Branches:70]Address:3#""))  // if found a branch with an address
		$address:=[Branches:70]Address:3
	Else 
		$address:=getCompanyFullAddress
	End if 
Else 
	$address:=getCompanyFullAddress
End if 

$0:=$address