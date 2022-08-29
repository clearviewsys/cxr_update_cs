//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 06/29/16, 14:49:53
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: launchUpdateProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1)

C_LONGINT:C283($0; $iProcess)

C_LONGINT:C283($AutoPublish; $AutoRefresh; $Minutes; $iProcess)
C_TEXT:C284($processName)

$iProcess:=-1  //init
$processName:="autoUpdateRatesProcess"

ON ERR CALL:C155("SP_onError")

If (isSLAValid)  // this process should not work when the SLA is expired
	
	$iProcess:=Process number:C372($processName)
	
	Case of 
		: ($iProcess=0)
			C_LONGINT:C283($pid)
			$iProcess:=New process:C317("SP_updateRatesProcess"; 0; $processName; True:C214; *)
			BRING TO FRONT:C326($iProcess)
			
			
		: (Count parameters:C259=1)  //this is a new process so init
			
			Repeat 
				
				$Minutes:=<>updateFrequency  // update every 10 minutes
				$AutoRefresh:=Num:C11(<>isRefreshRatesOnByDefault)  // load the default 
				$AutoPublish:=Num:C11(<>autoPublishXMLRates)  // load the default
				
				If ($Minutes<=0)
					$Minutes:=10
				End if 
				
				If ($AutoRefresh=1)
					handleRefreshRatesNow
				End if 
				
				If ($AutoPublish=1)
					writeAndUploadXMLRates
					If (stringContains(<>COMPANYNAME; "Lotus"))
						writeLotusRatex
					End if 
				End if 
				
				
				DELAY PROCESS:C323(Current process:C322; $Minutes*60*60)
			Until (<>SP_Stop)
			
			
		Else   //this is existing so update
			BRING TO FRONT:C326($iProcess)
	End case 
	
End if 

$0:=$iProcess