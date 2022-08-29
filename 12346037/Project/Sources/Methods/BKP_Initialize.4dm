//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:25:38
// ----------------------------------------------------
// Method: BKP_Initialize
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($tDefaultXPath; $tDirSymbol)

BKP_InitializeGlobalVariables

$tDefaultXPath:="/Preferences4D/Backup"
$tDirSymbol:=BKP_GetDirGlyph
<>tDefaultXPath:=$tDefaultXPath

ARRAY TEXT:C222($documents; 0)
<>tBackupFileName:=Select document:C905(Helper_GetPath(Structure file:C489); ".xml;XML"; "Open Backup File"; 0; $documents)

If (<>tBackupFileName#"")
	
	// get the first document the user selected
	<>tBackupFileName:=$documents{1}
	<>tBackupPathName:=Helper_GetPath(<>tBackupFileName)
	
	If (Test path name:C476(<>tBackupFileName)=1)
		BKP_XML_GetAllPreferences($tDefaultXPath)
		BKP_LaunchApp
	Else 
		myAlert("Backup Preferences were not found!")
	End if 
End if 