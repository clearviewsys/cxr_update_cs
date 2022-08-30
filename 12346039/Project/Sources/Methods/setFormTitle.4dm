//%attributes = {}
//setFormTitle("Title"")

C_TEXT:C284($title; $1; vFormTitle)
$title:=$1

vFormTitle:=$title

If (Current user:C182="designer")
	vFormTitle:=vFormTitle+" | "+String:C10(Transaction level:C961)
End if 
