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

$vb_Valid:=Sync_Register("clearviewsys"; "25D8-09BD-FB52/999")  // this does the init
Sync_Control("Database_Start")

//If (Application type=4D Local mode) | (Application type=4D Server)
//`6/24/21 - lotus - need to udpate eWire server address automatically for rollout
If (False:C215)  //(stringContains (<>COMPANYNAME;"Lotus"))
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

Sync_logWorker("cxrLogger")
Sync_compressHttpBlob(True:C214)

Sync_batchSize(Num:C11(getKeyValue("sync.validation.batchsize"; "30")))
Sync_processSize(Num:C11(getKeyValue("sync.validation.processsize"; "0")))
Sync_hashMode(2)  // 4D Digest //1/28/20

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


//End if 