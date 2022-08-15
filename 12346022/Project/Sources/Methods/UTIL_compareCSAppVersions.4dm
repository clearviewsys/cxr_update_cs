//%attributes = {}

// ----------------------------------------------------
// User name (OS): Milan
// Date and time: 01/08/21, 04:08:52
// ----------------------------------------------------
// Method: UTIL_compareCSAppVersions
// Description
// 
// Returns object with both server and client application
// versions and build numbers
// Sets success property to true if both application
// versions and build numbers match, otherwise it sets
// it to False
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($0)

$0:=New object:C1471
$0.server:=New object:C1471
$0.client:=New object:C1471

$0.server:=UTIL_getServerAppVersion
$0.client:=UTIL_getAppVersion

$0.success:=False:C215

If ($0.server.appVersion=$0.client.appVersion)
	If ($0.server.buildNum=$0.client.buildNum)
		$0.success:=True:C214
	End if 
End if 
