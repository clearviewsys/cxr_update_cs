//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 08/23/18, 13:18:24
// ----------------------------------------------------
// Method: SYNC_createDefaultTableConfig
// Description
//    idea is to have this method setup the deafult table settings
// master default
// table defaults so that we have a common starting point
//
// Parameters

// state: 0=none, 1=send, 2=receive, 3=send and recieve, 4=send and recieve self, 5=recieve and send origin

// ----------------------------------------------------

//NOTE RUNNING THIS WILL OVERRIDE EXISTING SETTINGS FOR THE TABLE/SITE COMBMINATION


//?? SHOULD WE DELETE ALL PRIOR SETTINGS BEFORE ADDING THESE??? I think we should delete all before adding or check for duplicates




C_POINTER:C301($ptrNil)
myConfirm("This will delete any current table settings. Are you sure you want to continue?")

If (OK=1)
	READ WRITE:C146([Sync_Tables:82])
	QUERY:C277([Sync_Tables:82]; [Sync_Tables:82]Site_ID:3="*")
	DELETE SELECTION:C66([Sync_Tables:82])
	
	myConfirm("Is this a remote or sync server?"; "Remote"; "Sync Server")
	
	If (OK=1)  //-------- SETTINGS FOR A REMOTE SITE -------
		SYNC_setDefaultTableRules(True:C214)
	Else 
		SYNC_setDefaultTableRules(False:C215)
	End if 
End if 

UNLOAD RECORD:C212([Sync_Tables:82])
REDUCE SELECTION:C351([Sync_Tables:82]; 0)

READ ONLY:C145([Sync_Tables:82])