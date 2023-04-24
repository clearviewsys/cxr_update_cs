//%attributes = {"executedOnServer":true}
//
// >> ----------------------------------------------------
// >> User name(OS): Barclay Berry
// >> Date and time: 10/7/08, 14:47:54
// >> ----------------------------------------------------
// >> Method: UTIL_Log
// >> Description
// >> 
// >> 
// >> Parameters
// >> $1-Text-calling method name
// >> $2-Text-message to add to the log
// >> ----------------------------------------------------


// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/15/15, 12:03:37
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: UTIL_Log
// Description
//     ************ NEED TO MOVE TO OWN PROCESS *********
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tLogName)
C_TEXT:C284($2; $tLogMessage)

//C_BOOLEAN($3)  //new process ?  // added by: Barclay Berry (10/15/15)


C_TIME:C306($hLogRef)
C_LONGINT:C283($iProcess; $iPID)

$tLogName:=$1
$tLogMessage:=$2


If (True:C214)
	C_TEXT:C284($1)
	C_TEXT:C284($2)
	
	CALL WORKER:C1389("cxrLogger"; "UTIL_Logger"; $1; $2; Current user:C182)  //;WAPI_IPClient;WAPI_getSession ("username");WAPI_URL)
	
Else 
	$iProcess:=Process number:C372("$Util_Log")  //check for local process
	
	
	Case of 
		: ($iProcess=0)  //doesn't exist
			$iPID:=New process:C317("Util_Log"; 0; "$Util_Log"; $tLogName; $tLogMessage; True:C214; *)
			
		: (Count parameters:C259=3)  //new process so init
			LOG_tLogName:=$tLogName
			LOG_tLogMessage:=$tLogMessage
			
			UTIL_Logger
			
		Else   //existing process... update vars
			
			//Repeat 
			//GET PROCESS VARIABLE($iProcess;LOG_tLogName;$tCurrLogName)
			//Until ($tCurrLogName="")
			
			Repeat 
				
				C_BOOLEAN:C305($bExist)
				$bExist:=Test semaphore:C652("$UTIL_Log")
				If ($bExist=False:C215)
					SET PROCESS VARIABLE:C370($iProcess; LOG_tLogName; $tLogName)
					SET PROCESS VARIABLE:C370($iProcess; LOG_tLogMessage; $tLogMessage)
					RESUME PROCESS:C320($iProcess)
				Else 
					
				End if 
				
				DELAY PROCESS:C323(Current process:C322; 5)
			Until ($bExist=False:C215)
			
	End case 
	
End if 