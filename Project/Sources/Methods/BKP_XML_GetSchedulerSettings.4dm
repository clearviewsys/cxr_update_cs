//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:26:29
// ----------------------------------------------------
// Method: BKP_XML_GetSchedulerSettings
// Description
// 
//
// Parameters
// $1 -a reference to the parent element in the DOM
// ----------------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($iRet)

$iRet:=BKP_XML_GetSettings($1; "/Backup/Settings/Scheduler")
$iRet:=BKP_XML_GetSettings($1; "/Backup/Settings/Scheduler/Weekly")

$0:=$iRet