C_TEXT:C284($export)
C_LONGINT:C283($n)

If (False:C215)
	ARRAY BOOLEAN:C223(holdingsListBox; 0)
End if 

$n:=LISTBOX Get number of rows:C915(holdingsListBox)

If ($n=0)
	
	myConfirm("Shall I save this NO Records found document?")
	If (OK=1)
		$export:=""
		$export:=$export+OBJECT Get title:C1068(*; "reportTitle")+"\r\n"
		$export:=$export+"Date range: "+String:C10(vFromDate)+" - "+String:C10(vToDate)+"\r\n"
		$export:=$export+"No records found for this period."+"\r\n"
		$export:=$export+"Run on: "+String:C10(Current date:C33)+" at "+String:C10(Current time:C178)+" || CurrencyXchanger"
		
		saveTextToFile($export)
	End if 
	
Else 
	listbox_requestExport(->holdingsListBox; OBJECT Get title:C1068(*; "reportTitle"))
End if 