HandleEntryFormMethod
If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrTableNames; 0)
	ARRAY TEXT:C222(arrFieldNames; 0)
	ARRAY LONGINT:C221(arrTableNums; 0)
	ARRAY LONGINT:C221(arrFieldNums; 0)
	arrTableNames:=0
	arrFieldNames:=0
	
	GET TABLE TITLES:C803(arrTableNames; arrTableNums)
	
End if 


setEnterableIff(([FieldConstraints:69]isConditional:7=True:C214); "conditionGroup")

