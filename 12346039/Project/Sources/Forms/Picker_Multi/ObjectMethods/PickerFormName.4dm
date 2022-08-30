Self:C308->:=Get localized string:C991("cvs_pick")+" "+Form:C1466.whichDataStore

If (Form:C1466.tableLabel#Null:C1517)
	If (Form:C1466.tableLabel#"")
		Self:C308->:=Get localized string:C991("cvs_pick")+" "+Form:C1466.tableLabel
	End if 
End if 
