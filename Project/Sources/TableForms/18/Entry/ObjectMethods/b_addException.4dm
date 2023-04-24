C_LONGINT:C283($i)

If (arrTableNumbers>0)
	For ($i; 1; LISTBOX Get number of rows:C915(lbTableNames))
		If (lbTableNames{$i})
			createRecordTableLimitations(arrTableNumbers{$i}; True:C214; -1; nullDate)
		End if 
	End for 
	ALL RECORDS:C47([TableLimitations:55])
Else 
	ALERT:C41("Please select a table first")
End if 