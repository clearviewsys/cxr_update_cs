If (False:C215)
	ARRAY BOOLEAN:C223(holdingsListBox; 0)
End if 

C_TEXT:C284($title)
$title:="P&L Report for "+String:C10(vFromDate)+" to "+String:C10(vToDate)
If (OK=1)
	rep_listbox2table(->holdingsListBox; $title)
End if 
