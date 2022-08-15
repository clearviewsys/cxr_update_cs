
//Self->:=getElegantTableName (Current form table)

If (Is nil pointer:C315(Current form table:C627))
	SET WINDOW TITLE:C213(getElegantTableName(Current default table:C363); Current form window:C827)
Else 
	SET WINDOW TITLE:C213(getElegantTableName(Current form table:C627); Current form window:C827)
End if 