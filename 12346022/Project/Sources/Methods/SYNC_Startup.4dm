//%attributes = {}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/29/12, 12:39:56
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: SYNC_Startup
// Description
// 
//
// Parameters
// ----------------------------------------------------



//C_BOOLEAN(<>SYNC_Is_Enabled;<>SYNC_Is_Paused)
//C_TEXT(<>SYNC_Site_Code)

C_BOOLEAN:C305($vb_Valid)
C_TEXT:C284($ip; $ewireserver; $ref)
C_LONGINT:C283($elem)

$vb_Valid:=XB_Register("clearviewsys"; "7423-DB12-082E")
If (Application type:C494=4D Server:K5:6)
	XB_SetOption("Alert"; False:C215)  // Modified by: Barclay Berry (9/3/13)
End if 


//`6/24/21 - lotus - need to udpate eWire server address automatically for rollout
If (stringContains(<>COMPANYNAME; "Lotus"))
	If (getKeyValue("sync.ewireserver.updated"; "false")="false")  //`ùse keyvalue to record we did this already
		$ip:=getKeyValue("sync.ewireserver.ipaddress"; "25.7.98.78")
		If ($ip="")
		Else 
			$ewireserver:=getKeyValue("sync.ewireserve.name"; "EWIR")
			Sync_File("read")
			$ref:=Sync_Get_ConfigRef
			
			$elem:=XB_FindInArray($ref; "RemoteSite.Identifier"; $ewireserver)
			If ($elem>0)
				XB_PutArrayText($ref; "RemoteSite.URL"; $elem; $ip)
				
				Sync_File("write")
				
				setKeyValue("sync.ewireserver.updated"; "true")
			End if 
			
		End if 
	End if 
End if 

$vb_Valid:=Sync_Register("clearviewsys"; "25D8-09BD-FB52/999")

Sync_compressHttpBlob(True:C214)

Sync_Control("Database_Start")
//Sync_Control ("Trigger_ON")

//<>SYNC_Site_Code:=Sync_Info ("SiteCode")  //This will assign the current sync site ID to variable

//SYNC_Is_Paused (False)

If (Sync_Is_Status_On("Active"))
	Sync_Log(Current method name:C684; "SYNC is starting up.")
	
	If (Sync_Info("SiteCode")="") | (Sync_Info("SiteCode")="TEST") | (Sync_Info("SiteCode")="TEMP")
		READ ONLY:C145([CompanyInfo:7])
		ALL RECORDS:C47([CompanyInfo:7])
		If ([CompanyInfo:7]BranchPrefix:17#"")
			Sync_Set_GlobalVar("<>vt_Sync_SiteCode"; [CompanyInfo:7]BranchPrefix:17)
		End if 
	End if 
	
Else 
	Sync_Log(Current method name:C684; "SYNC is NOT active.")
End if 

Sync_hashMode(4D digest:K66:3)  //1/28/20