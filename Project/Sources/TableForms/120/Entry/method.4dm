HandleEntryFormMethod

If (Form event code:C388=On Load:K2:1)
	// populate the list of table names and numbers
	ARRAY TEXT:C222(arrTableNames; 0)
	ARRAY LONGINT:C221(arrTableNums; 0)
	arrTableNames:=0
	arrTableNums:=0
	
	GET TABLE TITLES:C803(arrTableNames; arrTableNums)
	
End if 