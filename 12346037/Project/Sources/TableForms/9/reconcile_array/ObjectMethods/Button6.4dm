C_LONGINT:C283($i)
CONFIRM:C162("Are you sure you want to uncheck all checked rows in selection?")
If (OK=1)
	For ($i; 1; Size of array:C274(arrDates))
		If (reconcileList{$i})  // selected
			arrChecked{$i}:=False:C215
		End if 
	End for 
End if 