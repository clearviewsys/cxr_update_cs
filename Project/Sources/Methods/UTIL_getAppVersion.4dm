//%attributes = {}

// ----------------------------------------------------
// User name (OS): Milan
// Date and time: 01/08/21, 04:06:46
// ----------------------------------------------------
// Method: UTIL_getAppVersion
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($buildNum)
C_OBJECT:C1216($0)

$0:=New object:C1471

$0.appVersion:=Application version:C493($buildNum; *)
$0.buildNum:=$buildNum
$0.final:=$0.appVersion[[1]]
$0.R:=$0.appVersion[[7]]
$0.revision:=$0.appVersion[[8]]
$0.version:=$0.appVersion[[5]]+$0.appVersion[[6]]
