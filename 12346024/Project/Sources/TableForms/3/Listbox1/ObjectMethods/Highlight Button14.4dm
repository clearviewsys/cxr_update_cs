If (LISTBOX Get column width:C834(*; "colDOB")<6)
	LISTBOX SET COLUMN WIDTH:C833(*; "colDOB"; 80)
	LISTBOX SET COLUMN WIDTH:C833(*; "colPictureID"; 100)
	LISTBOX SET COLUMN WIDTH:C833(*; "colOccupation"; 100)
Else 
	LISTBOX SET COLUMN WIDTH:C833(*; "colDOB"; 0)
	LISTBOX SET COLUMN WIDTH:C833(*; "colPictureID"; 0)
	LISTBOX SET COLUMN WIDTH:C833(*; "colOccupation"; 0)
End if 