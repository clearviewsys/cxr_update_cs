C_LONGINT:C283($iSeqNo; $iTable)
C_POINTER:C301($ptr)

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "PREFS_TableList")

$iTable:=Selected list items:C379($ptr->; *)

myConfirm("Shall I auto reset the sequence number for : "+Table name:C256($iTable))

If (OK=1)
	$iSeqNo:=UTIL_resetSequenceNum(Table:C252($iTable))
	
	If ($iSeqNo=-1)
		myAlert("The sequence number could NOT be reset. You will have to manually adjust.")
	Else 
		myAlert(Table name:C256($iTable)+" sequence number now starts at: "+String:C10($iSeqNo+UTIL_getSequencePadding(Table:C252($iTable))))
	End if 
End if 