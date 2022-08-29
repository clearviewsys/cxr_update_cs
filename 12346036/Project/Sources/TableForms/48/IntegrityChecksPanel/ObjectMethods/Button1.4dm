C_TEXT:C284($method)
C_LONGINT:C283($n; $i)

$n:=Size of array:C274(arrToCheck)
For ($i; 1; $n)
	If (arrToCheck{$i})  // if checked then do the check
		arrStatus{$i}:="..."
		$method:="IC_"+arrCheckID{$i}
		EXECUTE METHOD:C1007($method)
		QUERY:C277([IC_FailedRecords:49]; [IC_FailedRecords:49]IntegrityCheckID:1=arrCheckID{$i})
		If (Records in selection:C76([IC_FailedRecords:49])=0)
			arrStatus{$i}:="Pass"
		Else 
			arrStatus{$i}:="Failed ("+String:C10(Records in selection:C76([IC_FailedRecords:49]))+")"
		End if 
	End if 
End for 
allRecordsIC_FailedRecords