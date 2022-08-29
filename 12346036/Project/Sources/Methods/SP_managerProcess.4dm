//%attributes = {}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 01/26/17, 12:26:45
// ----------------------------------------------------
// Method: SP_managerProcess
// Description
//     this stored procedure is responsible for monitoring other 
//    stored procedures. If one dies this will restart the process
//
// --- EXECUTE ON SERVER --- PROPERTY

// Parameters
// ----------------------------------------------------




//purpose: to start and make sure the SP_Services process is up and running

C_BOOLEAN:C305($1)

C_LONGINT:C283($0; $iProcess)

C_TEXT:C284($processName)

$processName:="SP_managerProcess"
ON ERR CALL:C155("SP_onError")

$iProcess:=Process number:C372($processName)


Case of 
	: ($iProcess=0)  //doesn't exist so start it up
		$iProcess:=New process:C317(Current method name:C684; 0; $processName; True:C214; *)
		BRING TO FRONT:C326($iProcess)
		
		
	: (Count parameters:C259=1)  //this starts the process
		C_LONGINT:C283(<>SP_calendarEventsProc_ID)
		C_LONGINT:C283(<>SP_autoUpdateRatesProc_ID)
		C_LONGINT:C283(<>SP_notificationProc_ID)
		
		C_BOOLEAN:C305(<>SP_Stop)
		
		
		READ ONLY:C145(*)
		
		<>SP_CalendarEventsProc_ID:=0
		<>SP_autoUpdateRatesProc_ID:=0
		<>SP_notificationProcess_ID:=0
		
		<>SP_Stop:=False:C215
		
		Repeat 
			
			If (<>SP_Stop)
				//call monitored processes so they will shut down
				//if the process is currently delayed this will start immediate and then "STOP"
				RESUME PROCESS:C320(<>SP_CalendarEventsProc_ID)
				RESUME PROCESS:C320(<>SP_notificationProc_ID)
				RESUME PROCESS:C320(<>SP_autoUpdateRatesProc_ID)
				
			Else 
				
				//---------- CALENDAR EVENTS PROCESS ---------------
				If ((Process state:C330(<>SP_CalendarEventsProc_ID)=Aborted:K13:1) | (Process state:C330(<>SP_CalendarEventsProc_ID)=Does not exist:K13:3))
					
					<>SP_CalendarEventsProc_ID:=SP_calendarEventsProcess
					
					If (<>SP_CalendarEventsProc_ID=0)
						UTIL_Log("SP_Services"; "SP_calendarEventsProcess FAILED TO START by "+Current method name:C684)
					Else 
						UTIL_Log("SP_Services"; "SP_calendarEventsProcess started by "+Current method name:C684)
					End if 
					
				End if 
				
				
				
				//------------ AUTO UPDATE RATES PROCESS -----------
				If (Application type:C494=4D Remote mode:K5:5)  //don't run on remotes
				Else 
					If ((Process state:C330(<>SP_autoUpdateRatesProc_ID)=Aborted:K13:1) | (Process state:C330(<>SP_autoUpdateRatesProc_ID)=Does not exist:K13:3))
						<>SP_autoUpdateRatesProc_ID:=SP_updateRatesProcess
						
						Case of 
							: (<>SP_autoUpdateRatesProc_ID=-1)  //SLA not activated
								UTIL_Log("SP_Services"; "AutoUpdateRates Services SLA NOT Valid: "+Current method name:C684)
							: (<>SP_autoUpdateRatesProc_ID=0)
								UTIL_Log("SP_Services"; "AutoUpdateRates Services FAILED TO START by "+Current method name:C684)
							Else 
								UTIL_Log("SP_Services"; "AutoUpdateRates Services started by "+Current method name:C684)
						End case 
						
					End if 
				End if 
				
				
				
				//-----------NOTIFICATION PROCESS --------------
				If ((Process state:C330(<>SP_notificationProc_ID)=Aborted:K13:1) | (Process state:C330(<>SP_notificationProc_ID)=Does not exist:K13:3))
					
					<>SP_notificationProc_ID:=SP_notificationProcess
					
					If (<>SP_notificationProc_ID=0)
						UTIL_Log("SP_Services"; "SP_notificationProcess FAILED TO START by "+Current method name:C684)
					Else 
						UTIL_Log("SP_Services"; "SP_notificationProcess started by "+Current method name:C684)
					End if 
					
				End if 
				
				
			End if 
			
			
			DELAY PROCESS:C323(Current process:C322; 360)
			//loop until the SP is told to stop execution
			
		Until (<>SP_Stop)
		
	Else 
		BRING TO FRONT:C326($iProcess)
End case 

$0:=$iProcess