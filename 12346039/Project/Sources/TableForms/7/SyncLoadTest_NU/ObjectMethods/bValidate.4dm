//
//  //C_BLOB($xBlob)
//  //
//  //XB_PutText (SYNC_tConfigBag;"Site.Identifier";SYNC_sSiteID)
//  //XB_PutText (SYNC_tConfigBag;"Site.Password";SYNC_sSitePassword)
//  //XB_PutText (SYNC_tConfigBag;"send.interval";SYNC_sSendInterval)
//  //XB_PutText (SYNC_tConfigBag;"send.timeout";SYNC_sSendTimeout)
//  //
//  //XB_PutLong (SYNC_tConfigBag;"Site.TimeServer.Zone";SYNC_atTimeZone-13)
//  //
//  //  //logging
//  //XB_PutLong (SYNC_tConfigBag;"Log.Receive.Level";SYNC_atReceiveLog-1)
//  //XB_PutText (SYNC_tConfigBag;"Log.Receive.Path";SYNC_tReceiveLogPath)
//  //XB_PutLong (SYNC_tConfigBag;"Log.Send.Level";SYNC_atSendLog-1)
//  //XB_PutText (SYNC_tConfigBag;"Log.send.Path";SYNC_tSendLogPath)
//  //
//  //  //Remote Sites
//  //XB_PutArray (SYNC_tConfigBag;"RemoteSite.Identifier";->at_SyncTo_Identifier)
//  //XB_PutArray (SYNC_tConfigBag;"RemoteSite.Password";->at_SyncTo_Password)
//  //XB_PutArray (SYNC_tConfigBag;"RemoteSite.URL";->at_SyncTo_URL)
//  //XB_PutArray (SYNC_tConfigBag;"RemoteSite.Send";->ab_SyncTo_Send)
//  //XB_PutArray (SYNC_tConfigBag;"RemoteSite.Receive";->ab_SyncTo_Receive)
//  //
//  //$xBlob:=XB_BagToBlob (SYNC_tConfigBag)
//SYNC_SettingsFile_NU ("Write";SYNC_SettingsSet2Blob_NU (SYNC_tConfigBag))
//
//XB_Clear (SYNC_tConfigBag)
