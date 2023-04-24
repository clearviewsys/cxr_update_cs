//%attributes = {}
// performs tasks in headless mode: compiling, building, ...
// usually in GitHub actions runners

#DECLARE->$inHeadless : Boolean

var $getDBParValue : Real
var $startupParam; $oldErrorHandler; $myParams : Text
var $config; $status; $buildStatus : Object

$inHeadless:=Get application info:C1599.headless

If (True:C214)  // new building code
	
	
	If ($inHeadless)
		
		build_logPlatformInfo
		
		$getDBParValue:=Get database parameter:C643(User param value:K37:94; $startupParam)
		
		If (Length:C16($startupParam)>0)
			logLineInLogEvent("parsing user parameters passed to 4D\n"+$startupParam+"\n\n")
			If (Is Windows:C1573)
				logLineInLogEvent("decoding parameters from Base64\n")
				BASE64 DECODE:C896($startupParam; $myParams)
			Else 
				$myParams:=$startupParam
			End if 
			logLineInLogEvent("parsing final user parameters\n\n "+$myParams+"\n\n")
			$config:=JSON Parse:C1218($myParams)
			If ($config#Null:C1517)
				build_logMe("config not null")
				build_logMe("build number is: "+String:C10($config.build))
			Else 
				build_logMe("It is null, quitting 4D later")
			End if 
		Else 
			logLineInLogEvent("no user parameters passed to 4D")
		End if 
		
		If ($config#Null:C1517)
			
			// which actions to take into account
			
			If (Is macOS:C1572)
				$config.action:=$config.actionMac
			Else 
				If (Is Windows:C1573)
					$config.action:=$config.actionWin
				Else 
					$config.action:=$config.actionOther
				End if 
			End if 
			
			If ($config.action=Null:C1517)
				$config.action:="RUN_ONLY"
			End if 
			
			// dump config action in artifacts
			
			build_dumpVar2File(JSON Stringify:C1217($config); "config_before.json")
			
			If (Position:C15("RUN_ONLY"; $config.action)=0)  // ignore other actions if RUN_ONLY is present in string
				
				// ON ERR CALL("build_errorHandler")
				
				// always compile regardless of action we have to perform
				
				logLineInLogEvent("Compiling ...")
				
				$status:=build_CompileOnly
				
				logLineInLogEvent("Compiling done...")
				
				
				
				If ($status.success)
					
					logLineInLogEvent("Making version and build file")
					
					build_makeVersionBuildFile
					
					logLineInLogEvent("Start building ...")
					
					$buildStatus:=build_all($config)
					
					If ($buildStatus.success)
						logLineInLogEvent("Building done OK...")
					End if 
					
				Else 
					
					// compilation failed, dump status file so github action will not run further
					
					build_dumpVar2File("compilation failed"; "status.log")
					
				End if 
				
				logLineInLogEvent("Quitting 4D")
				
				QUIT 4D:C291
				
			Else 
				
				// RUN_ONLY action present in user-params
				// return false to allow running in headless as headless server, do not QUIT 4D
				
				$inHeadless:=False:C215
				
			End if 
			
		Else 
			
			logLineInLogEvent("No user-params present - quitting 4D ...")
			
			QUIT 4D:C291
			
		End if 
		
	Else 
		
		logLineInLogEvent("4D IS NOT IN HEADLESS MODE!!!")
		
	End if 
	
Else 
	
	If ($inHeadless)
		
		build_logPlatformInfo
		
		$getDBParValue:=Get database parameter:C643(User param value:K37:94; $startupParam)
		
		If (Length:C16($startupParam)>0)
			logLineInLogEvent("parsing user parameters\n\n "+$startupParam+"\n\n")
			$config:=JSON Parse:C1218($startupParam)
		Else 
			logLineInLogEvent("no user parameters passed to 4D")
		End if 
		
		If ($config#Null:C1517)
			
			// which actions to take into account
			
			If (Is macOS:C1572)
				$config.action:=$config.actionMac
			Else 
				If (Is Windows:C1573)
					$config.action:=$config.actionWin
				Else 
					$config.action:=$config.actionOther
				End if 
			End if 
			
			If ($config.action=Null:C1517)
				$config.action:="RUN_ONLY"
			End if 
			
			// dump config action in artifacts
			
			build_dumpVar2File(JSON Stringify:C1217($config); "config_before.json")
			
			If (Position:C15("RUN_ONLY"; $config.action)=0)  // ignore other actions if RUN_ONLY is present in string
				
				$oldErrorHandler:=Method called on error:C704
				
				ON ERR CALL:C155("build_errorHandler")
				
				// always compile regardless of action we have to perform
				
				logLineInLogEvent("Compiling ...")
				
				$status:=build_CompileOnly
				
				logLineInLogEvent("Compiling done...")
				
				If ($status.success)
					
					logLineInLogEvent("Making version and build file")
					
					build_makeVersionBuildFile
					
					logLineInLogEvent("Start building ...")
					
					$buildStatus:=build_all($config)
					
					If ($buildStatus.success)
						logLineInLogEvent("Building done OK...")
					End if 
					
				Else 
					
					// compilation failed, dump status file so github action will not run further
					
					build_dumpVar2File("compilation failed"; "status.log")
					
				End if 
				
				ON ERR CALL:C155("")
				
				QUIT 4D:C291
				
			Else 
				
				// RUN_ONLY action present in user-params
				// return false to allow running in headless as headless server, do not QUIT 4D
				
				$inHeadless:=False:C215
				
			End if 
			
		Else 
			
			logLineInLogEvent("No user-params present - quitting 4D ...")
			
			QUIT 4D:C291
			
		End if 
		
	Else 
		
		logLineInLogEvent("4D IS NOT IN HEADLESS MODE!!!")
		
	End if 
	
End if 
