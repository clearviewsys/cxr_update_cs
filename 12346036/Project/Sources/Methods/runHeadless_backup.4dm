//%attributes = {}
//// performs tasks in headless mode: compiling, building, ...
//// usually in GitHub actions runners

//#DECLARE->$inHeadless : Boolean

//var $r : Real
//var $startupParam : Text
//var $config; $status : Object

//$inHeadless:=Get application info.headless


//If ($inHeadless)

//build_logPlatformInfo

//$r:=Get database parameter(User param value; $startupParam)

//If (Length($startupParam)>0)

//logLineInLogEvent("parsing user parameters\n\n "+$startupParam+"\n")
//$config:=JSON Parse($startupParam)

//Else 

//logLineInLogEvent("no user parameters passed ")

//End if 

//If ($config#Null)

//// do building, compiling or something else here based on $config.action

//Case of 

//: ($config.action="BUILD_APP")

//// do compile and build here

//logLineInLogEvent("in build")

//$status:=build_($config)

//If (Not($status.success))

//Else 

//// build_runPostBuildScript
//logLineInLogEvent("build ok")

//End if 


//: ($config.action="COMPILE_ONLY")

//// compile only

//logLineInLogEvent("Compilation")

//$status:=build_CompileOnly

//If (Not($status.success))

//// upload logs from runner for analysis


//End if 


//: ($config.action="COMPILED_STRUCTURE")

//logLineInLogEvent("Building compiled structure")

//$status:=build_CompiledStructure($config)

//If (Not($status.success))

//Else 

////build_runPostBuildScript
//logLineInLogEvent("Building compiled structure OK")

//End if 



//QUIT 4D

//Else 

//// no action specified
//logLineInLogEvent("in else")
//QUIT 4D

//End case 

//Else 

//// default to build or do nothing

//logLineInLogEvent("config not present")

//End if 

//logLineInLogEvent("Quitting 4D ...")

//QUIT 4D

//Else 
//logLineInLogEvent("⚠️⚠️⚠️NOT IN HEADLESS⚠️⚠️⚠️")
//End if 
