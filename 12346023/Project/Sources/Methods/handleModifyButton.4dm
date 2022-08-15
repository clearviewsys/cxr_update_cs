//%attributes = {"publishedWeb":true}
// handleModifyButton


If (Modified record:C314(Current form table:C627->))
	CONFIRM:C162("Do you want to Save the Changes?")
	If (OK=1)
		ACCEPT:C269
	Else 
		REJECT:C38
	End if 
End if 