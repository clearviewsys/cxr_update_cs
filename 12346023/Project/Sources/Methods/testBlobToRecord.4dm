//%attributes = {}
ALL RECORDS:C47([ServerPrefs:27])
C_BLOB:C604($blob)
loadBLOBFromFile(->$blob; "")

START TRANSACTION:C239

TM_Add2Stack(->[ServerPrefs:27]; Current method name:C684; Transaction level:C961)

READ WRITE:C146([ServerPrefs:27])

CREATE RECORD:C68([ServerPrefs:27])

BLOBToRecord(->[ServerPrefs:27]; ->$blob)

SAVE RECORD:C53([ServerPrefs:27])
UNLOAD RECORD:C212([ServerPrefs:27])

VALIDATE TRANSACTION:C240

TM_RemoveFromStack