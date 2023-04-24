//%attributes = {}
#DECLARE($config : Object)->$status : Object

var $compileStatus : Object
var $buildProjectPath; $oldErrorHandler; $buildLogPath : Text

$status:=New object:C1471
$status.success:=False:C215

If (Position:C15("BUILD_"; $config.action)>0)
	
	ON ERR CALL:C155("build_errorHandler")
	
	$buildProjectPath:=build_PrepareSettingsFile($config)
	
	logLineInLogEvent("Building ... "+$config.action)
	logLineInLogEvent("Using build settings file: "+$buildProjectPath)
	
	If (Test path name:C476($buildProjectPath)=Is a document:K24:1)
		logLineInLogEvent("Build settings file exists: "+$buildProjectPath)
	Else 
		logLineInLogEvent("‼️ FATAL: build project file doesn't exist ‼️")
	End if 
	
	
	BUILD APPLICATION:C871($buildProjectPath)
	
	ON ERR CALL:C155("")
	
	$buildLogPath:=Get 4D file:C1418(Build application log file:K5:46)
	
	build_file2Artifacts($buildLogPath)
	
	If (OK=1)
		
		logLineInLogEvent("✅ Build success ✅")
		$status.success:=True:C214
		
	Else 
		
		logLineInLogEvent("‼️ Build failure ‼️")
		
		build_dumpVar2File("build failed"; "status.log")
		
	End if 
	
	
End if 
