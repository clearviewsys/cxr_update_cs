//%attributes = {}
// webBUpdate(->table;->primaryKey;->webPrimaryKey)


C_POINTER:C301($1; $2; $3)

If (webisContextAlive(webContextID))
	QUERY:C277($1->; $2->=$3->)
	LOAD RECORD:C52($1->)
	SetFieldsToVariables($1)
	
	SAVE RECORD:C53($1->)
	//UNLOAD RECORD($1->)
	
	web_SendUserAreaPage
Else 
	web_SendContextExpiredPage
End if 