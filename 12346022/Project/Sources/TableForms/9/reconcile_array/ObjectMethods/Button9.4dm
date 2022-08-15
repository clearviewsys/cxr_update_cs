If (Form event code:C388=On Clicked:K2:4)
	C_LONGINT:C283($row)
	$row:=getListBoxRowNumber(->reconcileList)
	If ($row>0)
		displayRecordID(arrExternalTableNums{$row}; arrExternalRefs{$row})
	End if 
End if 
