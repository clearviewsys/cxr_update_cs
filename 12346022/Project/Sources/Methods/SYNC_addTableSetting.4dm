//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 08/23/18, 15:18:36
// ----------------------------------------------------
// Method: SYNC_addTableSetting
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptrTable)
C_LONGINT:C283($2; $iState)
C_TEXT:C284($3; $tSite)

$ptrTable:=$1
$iState:=$2

If (Count parameters:C259>=3)
	$tSite:=$3
Else 
	$tSite:="*"
End if 


READ WRITE:C146([Sync_Tables:82])

If (Not:C34(Is nil pointer:C315($ptrTable)))
	QUERY:C277([Sync_Tables:82]; [Sync_Tables:82]Table_No:1=Table:C252($ptrTable); *)
	QUERY:C277([Sync_Tables:82];  & ; [Sync_Tables:82]Site_ID:3=$tSite)
Else 
	QUERY:C277([Sync_Tables:82]; [Sync_Tables:82]Table_No:1=0; *)
	QUERY:C277([Sync_Tables:82];  & ; [Sync_Tables:82]Site_ID:3=$tSite)
End if 

If (Records in selection:C76([Sync_Tables:82])>0)
	DELETE SELECTION:C66([Sync_Tables:82])
End if 

CREATE RECORD:C68([Sync_Tables:82])
[Sync_Tables:82]Site_ID:3:=$tSite
[Sync_Tables:82]Sync_State:2:=$iState
If (Is nil pointer:C315($ptrTable))
	[Sync_Tables:82]Table_No:1:=0
Else 
	[Sync_Tables:82]Table_No:1:=Table:C252($ptrTable)
End if 
[Sync_Tables:82]UUID:4:=Generate UUID:C1066
SAVE RECORD:C53([Sync_Tables:82])
