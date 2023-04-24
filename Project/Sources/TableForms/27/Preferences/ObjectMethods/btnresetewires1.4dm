C_LONGINT:C283($iSeqNo)
C_POINTER:C301($ptr)
C_LONGINT:C283($iTable)

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "PREFS_TableList")

$iTable:=Selected list items:C379($ptr->; *)

myConfirm("Do you want to manually reset the sequence number for : "+Table name:C256($iTable))

If (OK=1)
	$iSeqNo:=Num:C11(myRequest("What sequence number should I use?"))
	If (OK=1)
		SET DATABASE PARAMETER:C642(Table:C252($iTable)->; Table sequence number:K37:31; $iSeqNo-UTIL_getSequencePadding(Table:C252($iTable)))
		
		myAlert(Table name:C256($iTable)+" sequence number now starts at: "+String:C10($iSeqNo+UTIL_getSequencePadding(Table:C252($iTable))))
	End if 
End if 