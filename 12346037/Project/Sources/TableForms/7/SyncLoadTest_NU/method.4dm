//
//
//Case of 
//: (Form event=On Load)
//
//C_TEXT(SYNC_tConfigBag)
//  //C_BLOB($xBlob)
//  //SYNC_tConfigBag:=XB_New 
//  //$xBlob:=SYNC_SettingsFile ("Read")
//
//SYNC_tConfigBag:=XB_BlobToBag (SYNC_SettingsFile_NU ("Read"))
//
//SYNC_sSiteID:=XB_GetText (SYNC_tConfigBag;"Site.Identifier")
//SYNC_sSitePassword:=XB_GetText (SYNC_tConfigBag;"Site.Password")
//SYNC_sSendInterval:=XB_GetText (SYNC_tConfigBag;"send.interval")
//SYNC_sSendTimeout:=XB_GetText (SYNC_tConfigBag;"send.timeout")
//
//SYNC_atTimeZone:=13+XB_GetLong (SYNC_tConfigBag;"Site.TimeServer.Zone")
//
//SYNC_atReceiveLog:=1+XB_GetLong (SYNC_tConfigBag;"Log.Receive.Level")
//SYNC_tReceiveLogPath:=XB_GetText (SYNC_tConfigBag;"Log.Receive.Path")
//SYNC_atSendLog:=1+XB_GetLong (SYNC_tConfigBag;"Log.Send.Level")
//SYNC_tSendLogPath:=XB_GetText (SYNC_tConfigBag;"Log.send.Path")
//
//
//ARRAY BOOLEAN(SYNC_abSyncSites;0)  //listbox
//ARRAY TEXT(at_SyncTo_Identifier;0)
//ARRAY TEXT(at_SyncTo_Password;0)
//ARRAY TEXT(at_SyncTo_URL;0)
//ARRAY BOOLEAN(ab_SyncTo_Receive;0)
//ARRAY BOOLEAN(ab_SyncTo_Send;0)
//
//XB_GetArray (SYNC_tConfigBag;"RemoteSite.Identifier";->at_SyncTo_Identifier)
//XB_GetArray (SYNC_tConfigBag;"RemoteSite.Password";->at_SyncTo_Password)
//XB_GetArray (SYNC_tConfigBag;"RemoteSite.URL";->at_SyncTo_URL)
//XB_GetArray (SYNC_tConfigBag;"RemoteSite.Send";->ab_SyncTo_Send)
//XB_GetArray (SYNC_tConfigBag;"RemoteSite.Receive";->ab_SyncTo_Receive)
//
//
//SYNC_tLoadLog:=""
//SYNC_iCreateCount:=100
//SYNC_iCreateDelay:=1
//
//ARRAY TEXT(SYNC_atCreateTables;0)
//ARRAY LONGINT(SYNC_aiCreateTables;0)
//
//  //ALL RECORDS([Sync_Tables])
//QUERY([Sync_Tables];[Sync_Tables]Sync_State=1;*)
//QUERY([Sync_Tables]; | ;[Sync_Tables]Sync_State=3)
//
//ORDER BY([Sync_Tables];[Sync_Tables]Table_No;>)
//
//ARRAY LONGINT($aiTableNums;0)
//DISTINCT VALUES([Sync_Tables]Table_No;$aiTableNums)
//SORT ARRAY($aiTableNums)
//
//For ($i;1;Size of array($aiTableNums))
//If ($aiTableNums{$i}>0)
//APPEND TO ARRAY(SYNC_atCreateTables;Table name($aiTableNums{$i}))
//APPEND TO ARRAY(SYNC_aiCreateTables;$aiTableNums{$i})
//End if 
//
//End for 
//
//SORT ARRAY(SYNC_atCreateTables;SYNC_aiCreateTables)
//
//
//SET TIMER(60)
//
//
//
//: (Form event=On Timer)
//
//SYNC_iRecCount:=Records in table([Sync_Queue])
//
//Else 
//
//End case 