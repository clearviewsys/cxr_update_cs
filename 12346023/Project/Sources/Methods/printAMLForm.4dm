//%attributes = {}
CONFIRM:C162("Would you like to print a copy of the MLA form?"; "Yes"; "No")

If (OK=1)
	PRINT SETTINGS:C106
	setErrorTrap("printAMLForm"; "Something went wrong during printing")
	Print form:C5([CompanyInfo:7]; "AMLForm")
	endErrorTrap
	
End if 