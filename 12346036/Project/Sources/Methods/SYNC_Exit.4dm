//%attributes = {}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/29/12, 12:44:02
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: SYNC_Exit
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (Application type:C494=4D Remote mode:K5:5)  //don't shut down
Else 
	Sync_Control("Database_Exit")
	Sync_Log(Current method name:C684; "SYNC is shutting down.")
End if 


