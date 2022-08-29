//%attributes = {}
#DECLARE($config : Object)->$status : Object

var $compileStatus : Object
var $buildProjectPath; $oldErrorHandler : Text

$status:=New object:C1471
$status.success:=False:C215

If (Position:C15("BUILD_"; $config.action)>0)
	
	$oldErrorHandler:=Method called on error:C704
	
	ON ERR CALL:C155("build_errorHandler")
	
	$buildProjectPath:=build_PrepareSettingsFile($config)
	
	logLineInLogEvent("Building ... "+$config.action)
	
	BUILD APPLICATION:C871($buildProjectPath)
	
	If (OK=1)
		
		logLineInLogEvent("✅ Build success")
		$status.success:=True:C214
		
	Else 
		
		logLineInLogEvent("‼️ Build failure")
		
		build_dumpVar2File("build failed"; "status.log")
		
	End if 
	
	ON ERR CALL:C155($oldErrorHandler)
	
End if 
