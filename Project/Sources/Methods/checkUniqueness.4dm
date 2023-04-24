//%attributes = {}
// checkUniqueness (->searchtable; ->searchfield; ->valueField; titleOfField)
// this method checks to see if there is a dupplicate key

C_POINTER:C301($1; $2; $3)
C_TEXT:C284($4)
C_LONGINT:C283($found)
If ($3->="")
	checkAddError($4+" cannot be left blank.")  // primary keys cannot be left blank
Else 
	SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
	QUERY:C277($1->; $2->=$3->)
	If ($found>=1)
		checkAddError("The "+$4+" '"+$3->+"' already exists in "+getElegantTableName($1)+".")
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 
