//%attributes = {"shared":true}
//displaySelectedRecord(->table)
// display the current record of table in its view form

C_POINTER:C301($1)

If (Records in selection:C76($1->)>0)
	FIRST RECORD:C50($1->)
	READ ONLY:C145($1->)
	LOAD RECORD:C52($1->)
	If (Record number:C243($1->)>=0)
		COPY NAMED SELECTION:C331($1->; getTableNamedSelection($1))
		displayRecord($1; Selected record number:C246($1->))
	End if 
End if 
