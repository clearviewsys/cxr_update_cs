If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	pickBranchID(Self:C308)
End if 

relateOne(->[Branches:70]; ->[Users:25]BranchID:17; ->[Branches:70]BranchID:1)
