//%attributes = {}
// listboxSavePreferences ( ->listboxPtr; latestPreferences; objectName )
// Save Listbox preferences to table DB_Listboxes
// Created by CVS Dev. Team 3/2/2017

C_POINTER:C301($1; $listboxPtr)
C_BOOLEAN:C305($2; $latestPrefs)
C_TEXT:C284($3; $listBoxId)

C_OBJECT:C1216($listBoxPrefsObj)

Case of 
		
	: (Count parameters:C259=3)
		
		$listboxPtr:=$1
		$latestPrefs:=$2
		$listBoxId:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Save Listbox preferences

$listBoxPrefsObj:=listboxGetPreferences($listboxPtr)


READ WRITE:C146([DB_Listboxes:12])
QUERY:C277([DB_Listboxes:12]; [DB_Listboxes:12]UserID:4=getApplicationUser; *)
QUERY:C277([DB_Listboxes:12];  & ; [DB_Listboxes:12]ListboxID:2=$listBoxId)

If (Records in selection:C76([DB_Listboxes:12])=0)
	
	CREATE RECORD:C68([DB_Listboxes:12])
	[DB_Listboxes:12]UserID:4:=getApplicationUser  //<>ApplicationUser
	[DB_Listboxes:12]ListboxID:2:=$listBoxId
	
End if 

If ($latestPrefs)
	[DB_Listboxes:12]ListboxLatestPrefs:3:=$listBoxPrefsObj
	SAVE RECORD:C53([DB_Listboxes:12])
Else 
	[DB_Listboxes:12]ListboxDefaultPrefs:5:=$listBoxPrefsObj
	SAVE RECORD:C53([DB_Listboxes:12])
End if 
UNLOAD RECORD:C212([DB_Listboxes:12])
READ ONLY:C145([DB_Listboxes:12])
REDUCE SELECTION:C351([DB_Listboxes:12]; 0)
