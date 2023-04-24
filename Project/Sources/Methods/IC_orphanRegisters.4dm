//%attributes = {}
C_TEXT:C284(vBranchID)
C_LONGINT:C283(cbApplyDateRange)

If (True:C214)
	If (cbApplyDateRange=1)  // (vFromDate#!00-00-00!) & (vToDate#!00-00-00!)
		integrityChecksRun(JSON Stringify:C1217(New object:C1471("orphanRegisters"; "True"; "startDate"; vFromDate; "endDate"; vToDate)))
	Else 
		integrityChecksRun(JSON Stringify:C1217(New object:C1471("orphanRegisters"; "True"; "startDate"; Add to date:C393(Current date:C33; -10; 0; 0); "endDate"; Current date:C33)))
	End if 
Else 
	integrityCheck(->[Registers:10]; Current method name:C684; "Register linked to a missing invoice"; ->[Registers:10]RegisterDate:2; numToBoolean(1-cbApplyDateRange); ->[Registers:10]BranchID:39; vBranchID)
End if 