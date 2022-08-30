//ARRAY TEXT(tabBranches;2)
// not optimized
handleViewFormMethod

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	//RELATE MANY([Branches]BranchID)  // load the related records - disabled for optimization
	QUERY:C277([Users:25]; [Users:25]BranchID:17=[Branches:70]BranchID:1)
	QUERY:C277([ClientPrefs:26]; [ClientPrefs:26]BranchID:32=[Branches:70]BranchID:1)
End if 

// [registers];"listbox"