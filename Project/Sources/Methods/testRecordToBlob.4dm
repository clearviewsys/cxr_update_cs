//%attributes = {}
ALL RECORDS:C47([ServerPrefs:27])
C_BLOB:C604($aBLOB)
$aBLOB:=recordToBLOB(->[ServerPrefs:27])
saveBLOBtoFile($aBLOB; "")