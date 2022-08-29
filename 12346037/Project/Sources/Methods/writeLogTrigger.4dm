//%attributes = {}
// writeLogTrigger(string: primaryKey ; longint: errorReturn ($0 of the trigger))


//C_POINTER($1)

//C_LONGINT($2)

C_TEXT:C284($1)
C_LONGINT:C283($2; $dbEvent; $tableNum; $recordNum)
C_TEXT:C284($3)  // Modified by: Barclay (1/28/2012)
C_BOOLEAN:C305(<>activateLog)

//If (<>activateLog=True)  // disable
If (False:C215)  // disable
	
	READ WRITE:C146([SystemLogs:21])
	CREATE RECORD:C68([SystemLogs:21])
	TRIGGER PROPERTIES:C399(Trigger level:C398; $dbEvent; $tableNum; $recordNum)
	[SystemLogs:21]Date:2:=Current date:C33
	If (Count parameters:C259>=3)  // Modified by: Barclay (1/31/2012)
		[SystemLogs:21]Desc:8:=$3
	End if 
	[SystemLogs:21]LogID:1:=Sequence number:C244([SystemLogs:21])
	[SystemLogs:21]machine:5:=getCurrentMachineName
	[SystemLogs:21]TableNumber:6:=$tableNum
	[SystemLogs:21]Time:3:=Current time:C178
	[SystemLogs:21]Trigger:7:=$dbEvent
	Case of 
		: ([SystemLogs:21]Trigger:7=On Saving New Record Event:K3:1)
			[SystemLogs:21]Desc:8:="Save "+$1
		: ([SystemLogs:21]Trigger:7=On Saving Existing Record Event:K3:2)
			[SystemLogs:21]Desc:8:="Modify "+$1
		: ([SystemLogs:21]Trigger:7=On Deleting Record Event:K3:3)
			[SystemLogs:21]Desc:8:="Delete "+$1
	End case 
	
	[SystemLogs:21]User:4:=getApplicationUser  //<>ApplicationUser
	[SystemLogs:21]RecordNumber:9:=$recordNum
	[SystemLogs:21]ErrorNumber:10:=$2
	
	SAVE RECORD:C53([SystemLogs:21])
	UNLOAD RECORD:C212([SystemLogs:21])  // release record
	
	READ ONLY:C145([SystemLogs:21])
End if 