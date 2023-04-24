//%attributes = {}

C_TEXT:C284($1; $form)

If (Count parameters:C259>=1)
	$form:=$1
Else 
	$form:="Entry"
End if 

modifyRecord(->[LinkedDocs:4]; $form; "ListBox")

