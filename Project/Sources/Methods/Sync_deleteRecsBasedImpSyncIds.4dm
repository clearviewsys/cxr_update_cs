//%attributes = {}
// finds ea ch record in the ImportedSyncID table and deletes



C_LONGINT:C283($tableNo; $i; $iCount)
C_POINTER:C301($tablePtr; $syncIDFieldPtr2; $syncIDFieldPtr)

READ WRITE:C146([ImportedSyncIDs:127])
ALL RECORDS:C47([ImportedSyncIDs:127])
$iCount:=Records in selection:C76([ImportedSyncIDs:127])


ARRAY LONGINT:C221($aiRecNums; 0)
LONGINT ARRAY FROM SELECTION:C647([ImportedSyncIDs:127]; $aiRecNums)

If ($iCount>0)
	CONFIRM:C162("Are you sure you want to delete "+String:C10($iCount)+" records?")
	
	If (OK=1)
		For ($i; 1; $iCount)
			
			GOTO RECORD:C242([ImportedSyncIDs:127]; $aiRecNums{$i})
			
			$tablePtr:=Table:C252([ImportedSyncIDs:127]TableNo:2)
			$syncIDFieldPtr:=UTIL_getFieldPointer("["+Table name:C256($tablePtr)+"]"+"_Sync_ID")
			
			If (Is nil pointer:C315($syncIDFieldPtr))
			Else 
				READ WRITE:C146($tablePtr->)
				
				QUERY:C277($tablePtr->; $syncIDFieldPtr->=[ImportedSyncIDs:127]SyncID:1)
				
				If (Records in selection:C76($tablePtr->)=1)
					DELETE RECORD:C58($tablePtr->)
					
					If (OK=1)
						DELETE RECORD:C58([ImportedSyncIDs:127])
					End if 
				End if 
			End if 
			
		End for 
	End if 
	
End if 