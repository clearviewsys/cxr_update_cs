//%attributes = {}
// perform simulation of headless build process for debugging

var $params; $status; $buildStatus : Object
var $inHeadless : Boolean

$params:=build_getCurrentParameters

$inHeadless:=Get application info:C1599.headless

If (Not:C34($inHeadless))
	// get licenses from local repo
	
	$params.pathToLicenses:=Convert path system to POSIX:C1106(build_getLocalRepoLicensesPath)
	If (Is macOS:C1572)
		$params.pathToVL:=Convert path system to POSIX:C1106("Catalina:Applications:4D:4D v19.2:4D Volume Desktop.app:")
	Else 
		If (Is Windows:C1573)
			$params.pathToVL:=System folder:C487(Documents folder:K41:18)+"4D Volume Desktop\\"
		End if 
	End if 
End if 

build_logPlatformInfo

logLineInLogEvent("Compiling ...")

$status:=build_CompileOnly

If ($status.success)
	
	logLineInLogEvent("Building ...")
	
	$buildStatus:=build_all($params)
	
	If ($buildStatus.success)
		logLineInLogEvent("Building done OK...")
	End if 
	
End if 


