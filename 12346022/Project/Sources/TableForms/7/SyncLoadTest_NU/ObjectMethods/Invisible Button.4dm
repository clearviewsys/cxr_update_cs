

iLB_StartUp
iLB_TableBrowser_AddTable(->[Sync_Tables:82])
iLB_TableBrowser_AddTable(->[Sync_Queue:30])

READ ONLY:C145([Sync_Tables:82])

ALL RECORDS:C47([Sync_Tables:82])
C_LONGINT:C283($i)
For ($i; 1; Records in selection:C76([Sync_Tables:82]))
	//add all tables that have been config'd for sync
	If (Is table number valid:C999([Sync_Tables:82]Table_No:1))
		iLB_TableBrowser_AddTable(Table:C252([Sync_Tables:82]Table_No:1))
	End if 
	NEXT RECORD:C51([Sync_Tables:82])
End for 


iLB_Browser