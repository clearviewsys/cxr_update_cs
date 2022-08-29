//%attributes = {}

// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 11/28/16, 19:00:52
// ----------------------------------------------------
// Method: SP_mainProcess
// Description
//     This is the main stored procedure that monitors calendarEvents
//
// **** DO WE NEED A MONITOR PROCESS TO ENSURE THAT THIS IS ALWAYS RUNNING ****
// **** IE. WHAT IF AN EVENT CRASHES THE PROCESS --- SHOULD AUTO START AGAIN ****


//3/9/20 <>TODO -- IBB
// should this ONLY execute events with methods?
// should we NOT have client stored procedures... use the server to CALL REGISTERED CIENT ??

// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($1)

C_LONGINT:C283($0; $iProcess; $iPos)

C_TEXT:C284($processName; $tResult; $method; $param; $param2)
C_OBJECT:C1216($status)
C_TIME:C306($nextTime; $currTime)
C_LONGINT:C283($minutes)

$processName:="calendarEventsProcess"
$iProcess:=Process number:C372($processName)

$status:=New object:C1471

Case of 
	: ($iProcess=0)  //doesn't exist so start it up
		$iProcess:=New process:C317(Current method name:C684; 0; $processName; True:C214; *)
		BRING TO FRONT:C326($iProcess)
		
		
	: (Count parameters:C259=1)  //this is a new process so init
		
		C_LONGINT:C283($iCount; $i; $iError; $iWakeInterval; $iLoadFrequency; $iError)
		C_TEXT:C284($tBranch; $tUser; $tWorkstation)
		
		$tBranch:=<>branchID
		$tUser:=<>UserID
		$tWorkstation:=""
		
		$iWakeInterval:=60*60*1  //about every 1 minutes
		$iLoadFrequency:=10  // run the loadRemoteRecs_CalendarEvents every X times the process wakes
		$iCount:=0  //counter for the process - reset every time we reach the $iLoadFrequency
		
		
		ON ERR CALL:C155("SP_onError")
		
		UTIL_Log(Current method name:C684; "Starting Up....")
		
		Repeat 
			
			
			
			If (<>isSyncServer)  //| (<>branchID="")  //this is us or not assigned to branch
				//don't try this b/c it's us -- calendarEvents belong to the end users
			Else 
				
				If ($iError=0)
				Else 
					UTIL_Log(Current method name:C684; "loadRemoteRecs_CalendarEvents FAILED: "+String:C10($iError))
				End if 
				
				If (Records in table:C83([CalendarEvents:80])>0)
					READ WRITE:C146([CalendarEvents:80])
					QUERY:C277([CalendarEvents:80]; [CalendarEvents:80]isCompleted:17=False:C215)
					CREATE SET:C116([CalendarEvents:80]; "$notCompletedSet")
					
					//need to do more querying for next_DTS ...
					QUERY SELECTION:C341([CalendarEvents:80]; [CalendarEvents:80]nextScheduledDate:27=Current date:C33; *)
					QUERY SELECTION:C341([CalendarEvents:80];  & ; [CalendarEvents:80]nextScheduledTime:28<=Current time:C178)
					CREATE SET:C116([CalendarEvents:80]; "$todaySet")
					
					USE SET:C118("$notCompletedSet")
					QUERY SELECTION:C341([CalendarEvents:80]; [CalendarEvents:80]nextScheduledDate:27<Current date:C33)  //doesn't matter the time
					CREATE SET:C116([CalendarEvents:80]; "$pastSet")
					
					UNION:C120("$todaySet"; "$pastSet"; "$notCompletedSet")
					USE SET:C118("$notCompletedSet")
					
					CLEAR SET:C117("$todaySet")
					CLEAR SET:C117("$pastSet")
					
					If (False:C215)  //<>TODO - handle workstation/users via registered clients - need to review this
						// use execute on client to send to client workstation
						
						//GET CALENDAR EVENTS FOR TARGET ALL 
						USE SET:C118("$notCompletedSet")
						QUERY SELECTION:C341([CalendarEvents:80]; [CalendarEvents:80]Target_BID:19="")  //all sites
						CREATE SET:C116([CalendarEvents:80]; "$AllSet")
						
						//GET CALENDAR EVENTS FOR TARGET THIS BRANCH 
						USE SET:C118("$notCompletedSet")
						QUERY SELECTION:C341([CalendarEvents:80]; [CalendarEvents:80]Target_BID:19=$tBranch)  //this branch
						CREATE SET:C116([CalendarEvents:80]; "$BranchSet")
						
						//GET CALENDAR EVENTS FOR THIS TARGET USER --- <>TODO change to use registered client??? Tiran?
						USE SET:C118("$notCompletedSet")
						QUERY SELECTION:C341([CalendarEvents:80]; [CalendarEvents:80]TargetUser:10=$tUser)  //this logged in user
						CREATE SET:C116([CalendarEvents:80]; "$UserSet")
						
						//GET CALENDAR EVENTS FOR THIS TARGET WORKSTATION
						//USE SET("$notCompletedSet")
						//QUERY SELECTION([CalendarEvents];[CalendarEvents]Target_WID=$tWorkstation)  //this workstation
						//CREATE SET([CalendarEvents];"$WorkstationSet")
						
						//combine all the sets into one $notCompletedSet
						UNION:C120("$AllSet"; "$BranchSet"; "$notCompletedSet")  //reuse notCompletedSet
						UNION:C120("$notCompletedSet"; "$UserSet"; "$notCompletedSet")
						//UNION("$notCompletedSet";"$WorkstationSet";"$notCompletedSet")
					End if 
					
					
					USE SET:C118("$notCompletedSet")
					
					CLEAR SET:C117("$notCompletedSet")
					CLEAR SET:C117("$AllSet")
					CLEAR SET:C117("$BranchSet")
					CLEAR SET:C117("$UserSet")
					CLEAR SET:C117("$WorkstationSet")
					
					
					
					
					If (Records in selection:C76([CalendarEvents:80])>0)
						For ($i; 1; Records in selection:C76([CalendarEvents:80]))
							
							$iError:=0  //init
							$status.success:=True:C214
							$status.statusText:=[CalendarEvents:80]EventHeading:2
							
							
							
							If (Locked:C147([CalendarEvents:80]))  //locked?
								//skip for now -- probably someone editing is
								UTIL_Log(Current method name:C684; "[CalendarEvents] Record LOCKED: "+" : "+[CalendarEvents:80]EventHeading:2+" : "+String:C10([CalendarEvents:80]nextScheduledDate:27))
							Else 
								
								
								If ([CalendarEvents:80]executeMethod:23="")  //do nothing
								Else 
									
									//$iPos:=Position("<!--#4DEVAL";[CalendarEvents]executeMethod)  //use process 4d tags
									Case of 
										: (Position:C15("<!--#4DEVAL"; [CalendarEvents:80]executeMethod:23)>0)  //parameters have been sent in
											
											PROCESS 4D TAGS:C816([CalendarEvents:80]executeMethod:23; $tResult)
											
											$iError:=0
											
											Case of 
												: ($tResult="")
													$status.success:=True:C214
												: ($tResult="@## Error #@")
													$iError:=-1
													$status.success:=False:C215
													$status.statusText:=$tResult
												Else 
													$status.success:=True:C214
													$status.statusText:=$tResult
													UTIL_Log(Current method name:C684; "PROCESS 4D TAGS RESULT: "+[CalendarEvents:80]executeMethod:23+" : "+[CalendarEvents:80]EventHeading:2+" || "+$tResult)
											End case 
											
											
										: (Position:C15("/"; [CalendarEvents:80]executeMethod:23)>0)  //assum a parameter is passed in after /
											$iPos:=Position:C15("/"; [CalendarEvents:80]executeMethod:23)
											$method:=Substring:C12([CalendarEvents:80]executeMethod:23; 1; $iPos-1)
											$param:=Substring:C12([CalendarEvents:80]executeMethod:23; $iPos+1)
											$param2:=""
											
											$iPos:=Position:C15("/"; $param)
											If ($iPos>0)  //another param
												$param2:=Substring:C12($param; $iPos+1)
												$param:=Substring:C12($param; 1; $iPos-1)
											End if 
											
											If (UTIL_isMethodExists($method))
												EXECUTE METHOD:C1007($method; $status; $param; $param2)
											Else 
												$tResult:="Method Name NOT VALID: "+[CalendarEvents:80]executeMethod:23+" : "+[CalendarEvents:80]EventHeading:2
												UTIL_Log(Current method name:C684; $tResult)
												$iError:=-1
												$status.success:=False:C215
												$status.statusText:=$tResult
											End if 
											
											
										Else   //assume a method call
											
											If (UTIL_isMethodExists([CalendarEvents:80]executeMethod:23))
												If (False:C215)
													//Tiran was thinking there was an option to force the method to be executed on server
													//I don't see that currently but we can add a field and add execute on server here
												Else 
													EXECUTE METHOD:C1007([CalendarEvents:80]executeMethod:23; $status)  //assumes a $0 as longint
												End if 
											Else 
												$tResult:="Method Name NOT VALID: "+[CalendarEvents:80]executeMethod:23+" : "+[CalendarEvents:80]EventHeading:2
												UTIL_Log(Current method name:C684; $tResult)
												$iError:=-1
												$status.success:=False:C215
												$status.statusText:=$tResult
											End if 
											
									End case 
									
									
									If ($status.success)  //all good or no $0 passed back -1 is passed back with no
										[CalendarEvents:80]lastScheduledDate:29:=Current date:C33
										[CalendarEvents:80]lastScheduledTime:30:=Current time:C178
										
										If ([CalendarEvents:80]isRecurring:24)
											Case of 
												: ([CalendarEvents:80]RepeatsEveryNDay:25<=0)
													[CalendarEvents:80]RepeatsEveryNDay:25:=1
													
												: ([CalendarEvents:80]RepeatsEveryNDay:25<1)  //mutliple times a day
													$currTime:=Current time:C178
													$minutes:=(24*60)*[CalendarEvents:80]RepeatsEveryNDay:25
													$nextTime:=Time:C179($currTime+($minutes*60))%?24:00:00?
													
													If ($nextTime<$currTime)
														[CalendarEvents:80]nextScheduledDate:27:=Add to date:C393([CalendarEvents:80]lastScheduledDate:29; 0; 0; 1)
													End if 
													[CalendarEvents:80]nextScheduledTime:28:=$nextTime
													
													
												Else 
													[CalendarEvents:80]nextScheduledDate:27:=Add to date:C393([CalendarEvents:80]lastScheduledDate:29; 0; 0; [CalendarEvents:80]RepeatsEveryNDay:25)
													[CalendarEvents:80]nextScheduledTime:28:=[CalendarEvents:80]FromTime:5
											End case 
										Else 
											[CalendarEvents:80]isCompleted:17:=True:C214
										End if 
										
										SAVE RECORD:C53([CalendarEvents:80])
										
										If (True:C214)  //disable in production
											If ([CalendarEvents:80]isCompleted:17)
												UTIL_Log(Current method name:C684; "Execute Method SUCCESS: "+[CalendarEvents:80]executeMethod:23+" : "+[CalendarEvents:80]EventHeading:2+" : Marked COMPLETE")
											Else 
												UTIL_Log(Current method name:C684; "Execute Method SUCCESS: "+[CalendarEvents:80]executeMethod:23+" : "+[CalendarEvents:80]EventHeading:2+" Next run: "+String:C10([CalendarEvents:80]nextScheduledDate:27)+" at "+String:C10([CalendarEvents:80]nextScheduledTime:28))
											End if 
										End if 
										
									Else   //do logging or error notification here
										UTIL_Log(Current method name:C684; "Execute Method FAILED: "+[CalendarEvents:80]executeMethod:23+" : "+[CalendarEvents:80]EventHeading:2+" ERROR: "+String:C10($iError))
									End if 
									
									
								End if 
								
								
							End if 
							
							NEXT RECORD:C51([CalendarEvents:80])
						End for 
					End if 
					
					UNLOAD RECORD:C212([CalendarEvents:80])
				End if 
				
			End if 
			
			If (Is compiled mode:C492)
				DELAY PROCESS:C323(Current process:C322; $iWakeInterval)
			Else 
				DELAY PROCESS:C323(Current process:C322; $iWakeInterval/10)
			End if 
			
			If (False:C215)  //disable in production -- testing
				UTIL_Log(Current method name:C684; "Waking UP ....")
			End if 
			
			$iCount:=$iCount+1
			
		Until (<>SP_Stop)
		
		UTIL_Log(Current method name:C684; "Shutting Down....")
		
	Else 
		BRING TO FRONT:C326($iProcess)
End case 

$0:=$iProcess
