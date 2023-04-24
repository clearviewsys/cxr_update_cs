//%attributes = {}
If (Records in set:C195("UserSet")=1)
	C_TEXT:C284($clientName)
	USE SET:C118("UserSet")
	
	LOAD RECORD:C52([ClientPrefs:26])
	$clientName:=[ClientPrefs:26]ClientName:1
	DUPLICATE RECORD:C225([ClientPrefs:26])
	[ClientPrefs:26]ClientName:1:=$clientName+String:C10(Sequence number:C244([ClientPrefs:26]))
	
	//need to blank any _Sync_ID fields here
	
	SAVE RECORD:C53([ClientPrefs:26])
	UNLOAD RECORD:C212([ClientPrefs:26])
	allRecordsClientPrefs
	HIGHLIGHT RECORDS:C656([ClientPrefs:26]; "UserSet")
Else 
	myAlert("Please select one line as the template for duplication.")
End if 