//%attributes = {}
// pathSeparator -> String

// returns the path separator 

C_TEXT:C284($separator; $destinationPath)
C_TEXT:C284($0)

//C_LONGINT($vlPlatform;$vlSystem;$vlMachine)

//_O_PLATFORM PROPERTIES($vlPlatform;$vlSystem;$vlMachine)

//If ($vlPlatform=Windows)
//
//$separator:="\\"
//
//Else 
//
//$separator:=":"
//
//End if 

//$0:=$separator

// since version 12 we have a new 
$0:=Folder separator:K24:12