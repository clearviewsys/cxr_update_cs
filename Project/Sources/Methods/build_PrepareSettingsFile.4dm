//%attributes = {}
// prepares build settings file which will be passed to BUILD APPLICATION command later
// returns full path to resulting build settings file - we have to pass that path to BUILD APPLICATION command

#DECLARE($parameters : Object)->$path : Text

// $parameters.action - actions to perform: BUILD_APP|COMPILE_ONLY|COMPILED_STRUCTURE|BUILD_CS|RUN_ONLY
// $parameters.buildSettingsFileName - file name of build setting s file we will pass to BUILD APPLICATION command
// $parameters.templatePath - path to build settings template file we are going to build our build settings from
// $parameters.pathToLicenses - path to a folder containing developer licenses needed to perform compilation and/or building of application or compiled structure
// $parameters.destinationPath - path to folder where 4D will put built applications or compiled structure or components
// $parameters.appName - final application name if action is BUILD
// $parameters.pathToVL - path to folder containing 4D Volume License package for runner platform
// $parameters.pathToVLOther - path to folder containing 4D Volume license package for other platform
// $parameters.includeMacClient - include Mac client for automatic update of 4D Server: True or False
// $parameters.includeWinClient - include Windows client for automatic update of 4D Server: True or False


var $localDevLicensePaths : Collection
var $old_xml; $new_xml; $oneaction : Text
var $projectFolder : Object
var $actions : Collection

logLineInLogEvent("Preparing settings file ...")

$projectFolder:=Folder:C1567(fk database folder:K87:14)

If ($parameters=Null:C1517)
	$parameters:=New object:C1471
	$parameters.action:="RUN_ONLY"
End if 

$actions:=Split string:C1554($parameters.action; "|")

If ($parameters.buildSettingsFileName=Null:C1517)
	$parameters.buildSettingsFileName:="buildApp.4DSettings"
End if 

$path:=System folder:C487(Documents folder:K41:18)+$parameters.buildSettingsFileName

logLineInLogEvent("Build settings file path is "+$path)

// common code for building settings file regardless of action

If ($parameters.templatePath=Null:C1517)
	$parameters.templatePath:=build_getTemplatePath
	logLineInLogEvent("Got template path "+$parameters.templatePath)
Else 
	If (Is macOS:C1572)
		$parameters.templatePath:=Convert path POSIX to system:C1107($parameters.templatePath)
	End if 
End if 

logLineInLogEvent("Getting XML content from "+$parameters.templatePath)

$old_xml:=build_getBuildXMLFileContent($parameters.templatePath)

build_dumpVar2File($old_xml; "buildTemplateAtStart.xml")  // dump template to artifacts folder for debugging

If ($parameters.pathToLicenses=Null:C1517)
	$parameters.pathToLicenses:=System folder:C487(Documents folder:K41:18)+"Licenses"+Folder separator:K24:12
Else 
	If (Is macOS:C1572)
		$parameters.pathToLicenses:=Convert path POSIX to system:C1107($parameters.pathToLicenses)
	End if 
End if 

logLineInLogEvent("Getting dev licenses from "+$parameters.pathToLicenses)

$localDevLicensePaths:=build_getLocalDevLicenses($parameters.pathToLicenses)

logLineInLogEvent("Setting dev licenses path")

$new_xml:=build_setLicensesPath($localDevLicensePaths; $old_xml)

build_dumpVar2File($new_xml; "new_withlicenses.xml")

If ($parameters.destinationPath=Null:C1517)
	$parameters.destinationPath:=System folder:C487(Documents folder:K41:18)+"MyBuild"+Folder separator:K24:12
Else 
	If (Is macOS:C1572)
		$parameters.destinationPath:=Convert path POSIX to system:C1107($parameters.destinationPath)
	End if 
End if 

logLineInLogEvent("Setting destination path to: "+$parameters.destinationPath)

$new_xml:=build_setDestinationPath($parameters.destinationPath; $new_xml)

If ($parameters.appName=Null:C1517)
	$parameters.appName:="DefaultAppName"
End if 

$new_xml:=build_setAppName($parameters.appName; $new_xml)

logLineInLogEvent("App name set")

//========================================================
// action specific settings in build file

For each ($oneaction; $actions)
	
	logLineInLogEvent("Checking action "+$oneaction)
	
	If ($oneaction="BUILD_COMPILED_STRUCTURE")
		
		logLineInLogEvent("Setting XML for building compiled structure")
		
		$new_xml:=build_setCompiledStruct($new_xml; True:C214; True:C214)
		
	End if 
	
	
	If ($oneaction="BUILD_APP")
		
		logLineInLogEvent("Setting XML for build app")
		
		$new_xml:=build_setBuildAppSerialized($new_xml)  // set BuildApplicationSerialized to True
		
		logLineInLogEvent("Serialized set")
		
		If ($parameters.pathToVL=Null:C1517)
			If (Is macOS:C1572)
				$parameters.pathToVL:=System folder:C487(Documents folder:K41:18)+"4D Volume Desktop.app:"
			End if 
			If (Is Windows:C1573)
				$parameters.pathToVL:=System folder:C487(Documents folder:K41:18)+"4DVL\\4D Volume Desktop\\"
			End if 
		Else 
			If (Is macOS:C1572)
				$parameters.pathToVL:=Convert path POSIX to system:C1107($parameters.pathToVL)
			End if 
		End if 
		
		$new_xml:=build_setVLLocation($parameters.pathToVL; $new_xml)
		
		logLineInLogEvent("Setting Volume License location to "+$parameters.pathToVL)
		
	End if 
	
	
	If ($oneaction="BUILD_CS")
		
		// client-server building here
		
	End if 
	
	
End for each 

TEXT TO DOCUMENT:C1237($path; $new_xml; "UTF-8")  // put build setting file to a location 4D expect it to build application

build_dumpVar2File($new_xml; "buildApp_fromXMLVar.4DSettings")  // dump setting to artifacts folder for debugging

build_file2Artifacts($path)  // copy 4DSettings file to artifacts
