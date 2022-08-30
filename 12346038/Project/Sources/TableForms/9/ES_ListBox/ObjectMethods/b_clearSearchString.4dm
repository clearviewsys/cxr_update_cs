If (Form:C1466.searchString#Null:C1517)
	If (Form:C1466.searchString#"")
		Form:C1466.searchString:=""
		SET TIMER:C645(1)  // clear the search
	End if 
End if 