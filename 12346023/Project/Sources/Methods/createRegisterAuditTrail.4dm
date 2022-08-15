//%attributes = {}
// createRegistersAuditTrail (trigger)

C_POINTER:C301($tablePtr)
$tablePtr:=->[RegistersAuditTrail:88]
C_LONGINT:C283($trigger; $1)
$trigger:=$1

READ WRITE:C146($tablePtr->)
CREATE RECORD:C68($tablePtr->)

[RegistersAuditTrail:88]AuditTrailID:46:=makeauditTrailID
[RegistersAuditTrail:88]ActionTrigger:47:=getTriggerShortName($trigger)

//[RegistersAuditTrail]TriggerDate:=Current date // moved to trigger
//[RegistersAuditTrail]TriggerTime:=Current time
//[RegistersAuditTrail]triggerUser:=getApplicationUser  //ibb 

If ($trigger=On Saving Existing Record Event:K3:2)
	mapOldRegisterToAuditTrail
Else   // on deleting
	mapRegisterToAuditTrail
End if 

SAVE RECORD:C53($tablePtr->)
UNLOAD RECORD:C212($tablePtr->)
READ ONLY:C145($tablePtr->)
