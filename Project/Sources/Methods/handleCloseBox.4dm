//%attributes = {}
If (Form event code:C388=On Close Box:K2:21)
	CONFIRM:C162("Do you want to Save before closing?"; "Save"; "Back to form")
	If (OK=1)
		POST KEY:C465(Enter key:K12:26)
	End if 
End if 
