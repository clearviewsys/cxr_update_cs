
C_LONGINT:C283($iSeqNo)

If (True:C214)
	$iSeqNo:=UTIL_resetSequenceNum(->[Registers:10])
	[ServerPrefs:27]startRegisterNumber:2:=UTIL_getSequencePadding(->[Registers:10])
Else 
	C_TEXT:C284(vInvNumber)
	getLastOrderedRecord(->[Registers:10]; ->[Registers:10]RegisterID:1; ->vInvNumber)
	[ServerPrefs:27]startRegisterNumber:2:=Num:C11(vInvNumber)-Sequence number:C244([Registers:10])+1
	CLEAR VARIABLE:C89(vInvNumber)
	
End if 