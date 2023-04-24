//%attributes = {}


C_LONGINT:C283($i)
C_TEXT:C284($tmp)
START TRANSACTION:C239
For ($i; 1; 10)
	CREATE RECORD:C68([List_Relationships:136])
	[List_Relationships:136]Relationship:2:="Cousin"+" "+String:C10($i)+" "+String:C10(Current time:C178)
	
	SAVE RECORD:C53([List_Relationships:136])
End for 

$tmp:=Request:C163("Are you sure you want to save?")
If (OK=1)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 
