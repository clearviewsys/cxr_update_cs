//%attributes = {}
// get backup history file in v18+

C_OBJECT:C1216($backupHistory)
C_TEXT:C284($backupHistoryPath; $json)
C_COLLECTION:C1488($0)

$backupHistoryPath:=Get 4D file:C1418(Backup history file:K5:59)
$json:=Document to text:C1236($backupHistoryPath; "UTF-8")
$backupHistory:=JSON Parse:C1218($json)

ARRAY TEXT:C222($names; 0)
ARRAY LONGINT:C221($types; 0)

OB GET PROPERTY NAMES:C1232($backupHistory; $names; $types)

If (Size of array:C274($names)>0)
	$0:=$backupHistory[$names{1}]
End if 
