//%attributes = {}
// checks if we are running under Fetaure Release or Long Term Support 4D

#DECLARE->$isR : Boolean

var $version : Object

$version:=UTIL_getAppVersion

$isR:=False:C215

If ($version#Null:C1517)
	If ($version.R#"0")
		$isR:=True:C214
	End if 
End if 
