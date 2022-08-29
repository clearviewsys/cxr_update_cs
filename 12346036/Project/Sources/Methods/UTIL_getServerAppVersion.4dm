//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): Milan
// Date and time: 01/08/21, 04:04:49
// ----------------------------------------------------
// Method: UTIL_getServerAppVersion
// Description
// 
// Exactly the same method as UTIL_getAppVersion except this
// one must have Execute on server method property set
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($buildNum)
C_OBJECT:C1216($0)

$0:=New object:C1471

$0.appVersion:=Application version:C493($buildNum; *)
$0.buildNum:=$buildNum
