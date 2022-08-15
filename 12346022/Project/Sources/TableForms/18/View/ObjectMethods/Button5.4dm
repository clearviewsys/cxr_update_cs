C_TEXT:C284(vMACAddress)

If (isUserDesigner)
	C_BLOB:C604($aBLOB)
	$aBLOB:=recordToBLOB(->[MACs:18])
	saveBLOBtoFile($aBLOB; "")
End if 