//%attributes = {}
C_TEXT:C284(vBranchID)
C_LONGINT:C283(cbApplyDateRange)

If (True:C214)
	integrityChecksRun(JSON Stringify:C1217(New object:C1471("orphanRegisters"; "True")))
Else 
	integrityCheck(->[Registers:10]; Current method name:C684; "Register linked to a missing invoice"; ->[Registers:10]RegisterDate:2; numToBoolean(1-cbApplyDateRange); ->[Registers:10]BranchID:39; vBranchID)
End if 