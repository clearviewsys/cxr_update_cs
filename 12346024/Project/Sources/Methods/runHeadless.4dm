//%attributes = {}
// performs tasks in headless mode: compiling, building, ...
// usually in GitHub actions runners

#DECLARE->$inHeadless : Boolean

var $r : Real
var $startupParam : Text
var $config; $status; $buildStatus : Object

$inHeadless:=Get application info:C1599.headless

If ($inHeadless)
	
	build_logPlatformInfo
	
	$r:=Get database parameter:C643(User param value:K37:94; $startupParam)
	
	If (Length:C16($startupParam)>0)
		logLineInLogEvent("parsing user parameters\n\n "+$startupParam+"\n\n")
		$config:=JSON Parse:C1218($startupParam)
	Else 
		logLineInLogEvent("no user parameters passed ")
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
		
		If (Position:C15("RUN_ONLY"; $config.action)=0)  // ignore other actions if RUN_ONLY is present in string
			
			// always compile regardless of action
			
			logLineInLogEvent("Compiling ...")
			
			$status:=build_CompileOnly
			
			If ($status.success)
				
				logLineInLogEvent("Start building ...")
				
				$buildStatus:=build_all($config)
				
				If ($buildStatus.success)
					logLineInLogEvent("Building done OK...")
				End if 
				
			End if 
			
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
	logLineInLogEvent("NOT IN HEADLESS MODE")
End if 
