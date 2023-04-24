//%attributes = {}
C_POINTER:C301($tablePtr)
$tablePtr:=->[Registers:10]
READ WRITE:C146($tablePtr->)

QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[RegistersAuditTrail:88]orig_RegisterID:1)

If (Records in selection:C76([Registers:10])=0)
	CREATE RECORD:C68($tablePtr->)
Else 
	LOAD RECORD:C52($tablePtr->)
End if 
mapAuditTrailtoRegister
SAVE RECORD:C53($tablePtr->)
UNLOAD RECORD:C212($tablePtr->)
READ ONLY:C145($tablePtr->)