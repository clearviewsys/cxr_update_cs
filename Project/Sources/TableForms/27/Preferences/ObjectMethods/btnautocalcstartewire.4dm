C_LONGINT:C283($iSeqNo)

If (True:C214)
	$iSeqNo:=UTIL_resetSequenceNum(->[eWires:13])
	[ServerPrefs:27]starteWireNumber:3:=UTIL_getSequencePadding(->[eWires:13])
Else 
	C_TEXT:C284(vInvNumber)
	getLastOrderedRecord(->[eWires:13]; ->[eWires:13]eWireID:1; ->vInvNumber)
	[ServerPrefs:27]starteWireNumber:3:=Num:C11(vInvNumber)-Sequence number:C244([eWires:13])+1
	CLEAR VARIABLE:C89(vInvNumber)
End if 