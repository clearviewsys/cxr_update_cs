//%attributes = {}
CONFIRM:C162("Show today's cheques based on what?"; "Due Date"; "Issue Date")
If (OK=1)
	showTodaysTable(->[Cheques:1]; ->[Cheques:1]DueDate:3)
Else 
	showTodaysTable(->[Cheques:1]; ->[Cheques:1]IssueDate:16)
End if 