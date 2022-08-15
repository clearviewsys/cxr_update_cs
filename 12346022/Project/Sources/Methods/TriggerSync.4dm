//%attributes = {}
// this is a wrapper for the sync trigger
C_BOOLEAN:C305($1; $doRun)
C_BOOLEAN:C305($bLog)
C_TEXT:C284($tValue)

Case of 
	: (Count parameters:C259=1)
		$doRun:=$1
	Else 
		$doRun:=False:C215
End case 

$bLog:=False:C215



If ($doRun) & (Not:C34(Sync_IsSyncProcess))  //not a soap request
	$tValue:=""
	
	If (Trigger event:C369=On Saving New Record Event:K3:1)
		C_LONGINT:C283($iEvent; $iRecNum; $iTable)
		C_POINTER:C301($ptrSyncID)
		
		//TRACE
		//make sure syncID is blank -- just in case was a duplicate and not reset
		TRIGGER PROPERTIES:C399(Trigger level:C398; $iEvent; $iTable; $iRecNum)
		
		$ptrSyncID:=UTIL_getFieldPointer("["+Table name:C256($iTable)+"]_Sync_ID")
		If (Not:C34(Is nil pointer:C315($ptrSyncID)))
			$tValue:=$ptrSyncID->
			
			If ($tValue="")  //do nothing
			Else 
				If (Find in field:C653($ptrSyncID->; $tValue)=-1)  //all good no dup
				Else 
					//TRACE
					$ptrSyncID->:=""  //init -- what if recieving records from another site???
					$bLog:=True:C214
				End if 
			End if 
			
		End if 
	End if 
	
End if 

Sync_Trigger

If ($bLog)
	UTIL_Log(Current method name:C684; "Duplicate SYNCID found: "+$tValue+" for "+Table name:C256($iTable)+" record number: "+String:C10($iRecNum)+" changed to: "+$ptrSyncID->)
End if 